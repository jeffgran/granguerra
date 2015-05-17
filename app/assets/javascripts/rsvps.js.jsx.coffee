# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

PartySection = React.createClass
  getInitialState: ->
    coming: @props.serverdata.coming

  handleChange: ->
    @setState
      coming: @refs.isComing.getDOMNode().value == "true"
    @render()

  render: ->
    if @state.coming
      content = `<PartyYesSection partySize={this.props.serverdata.party_size} guestsdata={this.props.serverdata.guests} />`
    else
      content = `<input type="hidden" name="rsvp[party_size]" value="0" />`
    
    `coming_value = (this.state.coming === undefined ? null : this.state.coming)`
      
    `<div>
      <div className="form-group">
        <label className="col-sm-4 control-label">Can you make it?</label>
        <div className="col-sm-4">
          <select value={coming_value} required="required" name="rsvp[coming]" className="form-control" onChange={this.handleChange} ref="isComing">
            <option value={null}>...</option>
            <option value="true">Yes!</option>
            <option value="false">No.</option>
          </select>
        </div>
      </div>
      {content}
    </div>`


PartyYesSection = React.createClass
  getInitialState: ->
    partySize: @props.partySize || 1
    
  handleChange: (val) ->
    # console.log("party size changed to #{val}")
    @setState
      partySize: parseInt(val, 10)
    console.log(@state)
    @render()

  render: ->
    `<div>
      <PartySizeSelector changedCallback={this.handleChange} />
      <GuestList partySize={this.state.partySize} guestsdata={this.props.guestsdata} />
    </div>`


  
PartySizeSelector = React.createClass
  handleChange: ->
    @props.changedCallback(@refs.partySize.getDOMNode().value)
  
  render: ->
    options = []
    _.times 10, (i) ->
      options.push `<option key={i+1} value={i+1}>{i+1}</option>`
    `<div className="form-group">
      <label className="col-sm-4 control-label">How many in your party?</label>
      <div className="col-sm-4">
        <select required="required" name="rsvp[party_size]" className="form-control" onChange={this.handleChange} ref="partySize">
          {options}
        </select>
      </div>
    </div>`


  
GuestList = React.createClass
  render: ->
    guests = []
    _.times @props.partySize, (i) =>
      guestdata = @props.guestsdata[i] or {}
      guests.push `<GuestSection key={i} index={i+1} guestdata={guestdata} />`
    `<div id="guestList">{guests}</div>`


  
GuestSection = React.createClass
  getInitialState: ->
    name: @props.guestdata.name
    meal: @props.guestdata.meal

  render: ->
    options = _.map [
      ["", "Choose..."],
      ['steak', 'Steak - Grilled Filet of Beef with a Green Peppercorn Cognac Sauce and Mashed Potatoes'],
      ['salmon', 'Salmon - Pistashio Crusted Fillet on a bed of Baby Spinach'],
      ['vegetarian', 'Vegetarian - Portobello Ravioli with a Chardonnay Butter Sauce']
      ['child', 'Children\'s - Fried Chicken Tenders']
      ], (choiceArr, i) ->
      choiceValue = choiceArr[0]
      choiceName = choiceArr[1]
      `<option value={choiceValue} key={i}>{choiceName}</option>`
    `<div className="row guestRow">
      <div className="form-group">
        <div className="col-sm-1"></div>
        <label className="col-sm-3 control-label">Guest {this.props.index} Name for Placecard:</label>
        <div className="col-sm-4">
          <input defaultValue={this.state.name} required="required" id={"guest_name_"+this.props.index} name="rsvp[guests_attributes][][name]" type="text" className="form-control" />
        </div>
      </div>
            
      <div className="form-group">
        <div className="col-sm-1"></div>
        <label className="col-sm-3 control-label">Guest {this.props.index} Dinner Selection:</label>
        <div className="col-sm-4">
          <select defaultValue={this.state.meal} required="required" id={"guest_meal_"+this.props.index} name="rsvp[guests_attributes][][meal]" className="form-control">{options}</select>
        </div>
      </div>
    </div>`

  
$ ->
  sect = $('#partySection')
  if sect.length > 0
    sect_dom = sect[0]
    React.render `<PartySection serverdata={sect.data('serverdata')} />`, sect_dom

