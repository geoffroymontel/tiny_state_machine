require "tiny_state_machine/version"

module TinyStateMachine
  # raised when an invalid event is triggered
  class InvalidEvent < StandardError
  end

  # A tiny state machine
  # @example
  #   sm = TinyStateMachine::Machine.new :in_store do |sm|
  #     sm.event :buy, :in_store => :new
  #     sm.event :use, :new => :used
  #     sm.event :use, :used => :used
  #     sm.event :break, :used => :broken
  #     sm.event :fix, :broken => :used
  #     sm.on_state_change do |event, from_state, to_state|
  #       puts "new state = #{to_state}"
  #     end
  #   end

  class Machine
    # @return [String or Symbol] current state of the state machine.
    attr_reader :state

    # Construct a tiny state machine with an initial state.
    #
    # @param initial_state [String or Symbol] state the machine is in after initialization
    # @yield [self] yields the machine for easy definition of states
    # @yieldparam [Machine] self
    def initialize(initial_state)
      @state = initial_state
      @events = Array.new
      @callback_block = nil
      if block_given?
        yield self
      end
    end

    # declare events
    #
    # @param event [String or Symbol] state name
    # @param hash [Hash] a Hash in the form : old_state => new_state
    def event(event, hash)
      hash.each do |from, to|
        @events << { event: event, from: from, to: to }
      end
    end

    # trigger an event. 
    # It will return the new state the machine is in 
    # and call the listener's block
    #
    # @see on_state_change
    # @param event [String or Symbol] event to trigger
    # @raise [InvalidEvent] if the event is invalid (incorrect state)
    # @return the new state the machine is in
    def trigger(event)
      e = @events.find { |e| e[:event] == event && e[:from] == @state }
      raise InvalidEvent, "Invalid event '#{event}' from state '#{@state}'" if e.nil?
      old_state = @state
      @state = e[:to]
      @callback_block.call(event, old_state, @state) if @callback_block
      @state
    end

    # register a listener to a state change. 
    #
    # @param block [Proc] block that will be triggered
    def on_state_change(&block)
      @callback_block = block
    end
  end
end