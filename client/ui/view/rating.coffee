Template.rp_view_rating.created=->
  @value=new ReactiveVar(0)
  that=@
  if @data
    unless _.isArray(@data.values)
      if @data?.query
        Meteor.call 'getRatingResultsSummary',@data?.query,(err,res)->
          unless err
            if res then that.value.set(res[0]?.avgValue)
          else console.log err
          return
    else
      console.log @data.values
      @value.set(_.flatten(@data?.values).average('value'))


Template.rp_view_rating.helpers
  summaryData:->
    value:Template.instance().value.get()
    ,size:Template.instance().data.size or 'sm'
    ,docId:Template?.instance()?.data?.docId
    ,user:Template?.instance()?.data?.user



Template.rp_view_rating.events
  'click #showRpRatingComment':(evt,temp)->
    if temp?.data?.user and temp?.data?.docId
      Meteor.call 'getRatingItem',{audience:{$in:[temp.data.user]},docId:temp.data.docId},(err,res)->
        unless err
          Rp_Rating.modalHandle=Blaze.renderWithData(Template.rp_rating_comment,res,$('#rp_rating_content')[0])
        else
          console.log err
        return
      return
