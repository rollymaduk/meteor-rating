

Template.rp_create_rating.created=->
  {id,docId,collection,name,size,audience}=@data
  unless _.isString(id)
    check(docId,String)
    check(name,String)
    check(collection,String)

Template.rp_create_rating.events
  "click .rp_add_feedback":(evt,temp)->
    data=_.extend(temp.data,{mutable:true})
    Rp_Rating.modalHandle=Blaze.renderWithData(Template.rp_create_rating_detail,data,$('#rp_rating_content')[0])




