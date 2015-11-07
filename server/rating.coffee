class Rp_Rating_Server
  constructor:()->


    Meteor.publish('findRatingItem',(qry)->
      check(@userId,String)
      qry=_.extend(qry,{createdBy:@userId})
      Rp_Ratings.find(qry)
    )
    _pipeline=(qry)->
      [{$match:qry}
       {$unwind:data}
       {$project:{document:"$docId",description:'$data.description',title:"$data.title",value:"$data.value"}}
      ]
    Meteor.methods
      getRatingResultsByTitle:(qry)->
        check(qry,Object)
        pipeline=_pipeline(qry).push({$group:{_id:"$title",avg:"$value",desc:"$first":"$description"}})
        Rp_Ratings.aggregate(pipeline)

      getRatingResultsSummary:(qry)->
        check(qry,Object)
        pipeline=_pipeline(qry).push({$group:{_id:1,avg:"$value"}})
        Rp_Ratings.aggregate(pipeline)

      getRatingItem:(qry,modifier)->
        check(@userId,String)
        check(qry,Object)
        Rp_Ratings.findOne(qry,modifier)

      saveRatingResults:(rating)->
        console.log rating
        unless rating._id
          res=Rp_Ratings.insert(rating)
        else
          res=Rp_Ratings.update(rating._id,{$set:data:rating.data})
        Rp_Rating.ratingChanged.call null,rating
        res

  ratingChanged:(rating)->

  getRatings:(qry,modifier)->
    Rp_Ratings.find(qry,modifier)

Rp_Rating=new Rp_Rating_Server()
