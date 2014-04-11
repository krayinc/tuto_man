require 'tuto_man'

describe TutoManager::Helpers do
  before do
    @controller_class = Class.new
    @controller = @controller_class.new
    @controller_class.send(:include, TutoManager::Helpers)
    @controller.stub(:session).and_return(session)
  end

  describe "Interval mode" do
    before { TutoMan :foo }

    describe "#on?" do
      subject { @controller.tuto(:foo).on? }

      context "first time" do
        let(:session){ {} }
        it { should be_true }
      end

      context "recently shown" do
        let(:session){ {} }
        before { @controller.tuto(:foo).shown }
        it { should be_false }
      end

      context "shown long time ago" do
        let(:session){ {foo_shown_at: 2.days.ago.to_s} }
        it { should be_true }

        context "turned off" do
          before { @controller.tuto(:foo).off }
          it { should be_false }
        end
      end
    end
  end

  describe "After day of month mode" do
    before { TutoMan :bar, days_after: 20 }

    describe "#on?" do
      subject { @controller.tuto(:bar).on? }

      context "on Jan 15" do
        before { Time.stub(now: Time.new(2013, 1, 15)) }

        context "first time" do
          let(:session){ {} }
          it { should be_false }
        end

        context "second time" do
          let(:session){ {_next_bar_at: '2013-01-20 00:00:00 +0900'} }
          it { should be_false }
        end
      end

      context "on Jan 25" do
        before { Time.stub(now: Time.new(2013, 1, 25)) }

        context "first time" do
          let(:session){ {} }
          it { should be_true }
        end

        context "second time" do
          let(:session){ {_next_bar_at: '2013-02-20 00:00:00 +0900'} }
          it { should be_false }
        end
      end
    end

    describe "#shown" do
      let(:session){ {} }
      before do
        Time.stub(now: Time.new(2013, 1, mday))
        @controller.tuto(:bar).shown
      end
      subject { session[:_next_bar_at] }

      context "on Jan 15" do
        let(:mday){ 15 }
        it { should eq '2013-01-20 00:00:00 +0900' }
      end

      context "on Jan 25" do
        let(:mday){ 25 }
        it { should eq '2013-02-20 00:00:00 +0900' }
      end
    end
  end
end
