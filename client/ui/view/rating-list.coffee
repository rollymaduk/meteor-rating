Template.rp_rating_list.helpers
  rateComments:->
    Rp_Ratings.find().fetch()

Template.rp_rating_list.created=->
  console.log @data.query
  @subscribe "rp_ratings",@data.query,{limit:20,sort:{createdAt:-1}}