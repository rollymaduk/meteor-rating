Template.rp_view_rating.created=->
  @value=new ReactiveVar(0)
  unless _.isArray(@data.values)
    check(@data.query,Object)
    Meteor.call 'getRatingResultsSummary',@data.query,(err,res)=>
      unless err
        if res then @value.set(res[0].avg)
  else
    console.log @data.values
    @value.set(_.flatten(@data.values).average('value'))


Template.rp_view_rating.helpers
  summaryData:->
    value:Template.instance().value.get(),size:Template.instance().data.size or 'sm'



