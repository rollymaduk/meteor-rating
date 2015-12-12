Template.rp_rating_count.created=->
  @totalVotes=new ReactiveVar(0)
  @averageVotes=new ReactiveVar(0)
  that=@
  if @data.query
    Meteor.call 'getRatingTotalVotes',@data.query,(err,res)->
      if res then that.totalVotes.set(res[0].totalCount) else console.log err
    Meteor.call 'getRatingResultsSummary',@data.query,(err,res)->
      if res then that.averageVotes.set(Math.round(res[0].avgValue*10)/10) else console.log err

Template.rp_rating_count.helpers
  averageVotes:()->Template.instance().averageVotes.get()
  totalVotes:()->Template.instance().totalVotes.get()

