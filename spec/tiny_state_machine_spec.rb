require 'spec_helper'

module TinyStateMachine

  describe Machine do
    describe "#event" do
      it "should register an event" do
        sm = TinyStateMachine::Machine.new :in_store
        expect { sm.event :buy, :in_store => :new }.not_to raise_error
      end
    end

    describe "#on_state_change" do
      it "should register a callback block" do
        sm = TinyStateMachine::Machine.new :in_store
        expect { sm.on_state_change do |event, from_state, to_state|
          puts "new state = #{to_state}"
        end }.not_to raise_error
      end
    end

    describe "#trigger" do
      it "should return the new state if the event is valid" do
        sm = TinyStateMachine::Machine.new :in_store do |sm|
          sm.event :buy, :in_store => :new
        end
        expect(sm.trigger(:buy)).to eql :new
      end

      it "should raise an InvalidEvent error if the event is unknown" do
        sm = TinyStateMachine::Machine.new :in_store do |sm|
          sm.event :buy, :in_store => :new
        end
        expect { sm.trigger(:use) }.to raise_error(InvalidEvent)
      end

      it "should update the state machine state" do
        sm = TinyStateMachine::Machine.new :in_store do |sm|
          sm.event :buy, :in_store => :new
        end
        sm.trigger(:buy)
        expect(sm.state).to eql :new
      end

      it "should call the callback block" do
        callback = double('callback', :change => true)
        
        sm = TinyStateMachine::Machine.new :in_store do |sm|
          sm.event :buy, :in_store => :new
          sm.on_state_change do |event, from_state, to_state|
            callback.change(event, from_state, to_state)
          end
        end

        sm.trigger(:buy)
        expect(callback).to have_received(:change).with(:buy, :in_store, :new)
      end

      it "should handle events from :any state" do
        sm = TinyStateMachine::Machine.new :in_store do |sm|
          sm.event :buy, :any => :new
        end
        sm.trigger(:buy)
        expect(sm.state).to eql :new
      end
    end

  end

end