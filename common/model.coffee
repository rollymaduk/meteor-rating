@Rp_Rating_Model={}
Rp_Rating_Model.Rating=new SimpleSchema
  title:
    type:String
  description:
    type:String
  value:
    type:Number
    decimal:true

Rp_Rating_Model.RatingData=new SimpleSchema
  data:
    type:[Rp_Rating_Model.Rating]
  docId:
    type:String
    optional:true
  comment:
    type:String
    optional:true
  audience:
    type:[String]
    optional:true
  collection:
    type:String
    optional:true

@Rp_Ratings=new Meteor.Collection('rp_ratings',transform:(doc)->
  doc.owner=Meteor.users.findOne(doc.createdBy)
  doc.candidates=Meteor.users.find(_id:$in:doc.audience).fetch()
  doc
)
Rp_Ratings.attachSchema(Rp_Rating_Model.RatingData)
Rp_Ratings.attachBehaviour('timestampable')
