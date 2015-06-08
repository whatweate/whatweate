require "rails_helper"

describe Event do
  it { should have_many(:bookings).dependent(:destroy) }
  it { should have_many(:guests).through(:bookings) }

  describe "validations" do
    it { should validate_presence_of(:host_id) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:location_url) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:menu) }
    it { should validate_presence_of(:seats) }
    it { should validate_presence_of(:price_in_pennies) }
    it { should validate_presence_of(:currency) }
    it { should allow_value(1, 2).for(:seats) }
    it { should_not allow_value(0, -1, "20").for(:seats) }
    it { should allow_value("https://facebook.com", "https://twitter.com", "http://google.com", "http://www.fb.com").for(:location_url) }
    it { should_not allow_value("www.facebook.com", "facebook.com", "<script>alert('hello')</script>", "ftp://e.com").for(:location_url) }
  end

  describe "scopes" do
    describe "most_recent" do
      let!(:event_1) { FactoryGirl.create(:event, title: "Event 1", created_at: 2.weeks.ago) }
      let!(:event_2) { FactoryGirl.create(:event, title: "Event 2", created_at: 1.week.ago) }

      it "orders by the most recent first" do
        expect(described_class.most_recent).to eq [event_2, event_1]
      end
    end

    describe "approved" do
      let!(:pending) { FactoryGirl.create(:event, :pending) }
      let!(:approved) { FactoryGirl.create(:event) }
      let!(:sold_out) { FactoryGirl.create(:event, :sold_out) }

      it "returns approved and sold out events" do
        expect(described_class.approved).to match_array [approved, sold_out]
      end
    end

    describe "current" do
      let!(:tomorrow) { FactoryGirl.create(:event, date: Date.tomorrow) }
      let!(:today) { FactoryGirl.create(:event, date: Date.today) }
      let!(:yesterday) { FactoryGirl.create(:event, date: Date.yesterday) }

      it "returns past events" do
        expect(described_class.current).to match_array [today, tomorrow]
      end
    end

    describe "past" do
      let!(:tomorrow) { FactoryGirl.create(:event, date: Date.tomorrow) }
      let!(:today) { FactoryGirl.create(:event, date: Date.today) }
      let!(:yesterday) { FactoryGirl.create(:event, date: Date.yesterday) }

      it "returns past events" do
        expect(described_class.past).to eq [yesterday]
      end
    end
  end

  describe "#booked?" do
    let(:event) { FactoryGirl.create(:event) }
    let(:user) { FactoryGirl.create(:user) }

    it "returns true if the user has already made a booking" do
      Booking.create(event: event, user: user)
      expect(event.booked?(user)).to eq true
    end

    it "returns false when the user hasn't made a booking" do
      expect(event.booked?(user)).to eq false
    end
  end

  describe "states" do
    describe "pending" do
      it { expect(FactoryGirl.build(:event, :pending).pending?).to eq true }
    end

    describe "available" do
      it { expect(FactoryGirl.build(:event).available?).to eq true }
    end

    describe "sold_out" do
      it { expect(FactoryGirl.build(:event, :sold_out).sold_out?).to eq true }
    end
  end

  describe "transistions" do
    describe "approve" do
      let(:event) { FactoryGirl.create(:event, :pending) }

      it "pending -> available" do
        expect { event.approve }.to change { event.available? }.from(false).to(true)
      end
    end

    describe "fully_booked" do
      let(:event) { FactoryGirl.create(:event) }

      it "available -> sold_out" do
        expect { event.fully_booked }.to change { event.sold_out? }.from(false).to(true)
      end
    end
  end
end
