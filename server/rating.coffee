class Rp_Rating_Server
  constructor:()->
    Meteor.publish('rp_ratings',(qry,modifier={})->
      check(@userId,String)
      Rp_Ratings.find(qry,modifier)
    )
    _pipeline=(qry)->
      [{$match:qry}
       {$unwind:"$data"}
       {$project:{document:"$docId",description:'$data.description',title:"$data.title",value:"$data.value"}}
      ]
    Meteor.methods
      getRatingResultsByTitle:(qry)->
        check(qry,Object)
        pipeline=_pipeline(qry)
        pipeline.push({$group:{_id:"$title",title:{$first:"$title"},value:{$avg:"$value"},description:{$first:"$description"}}})
        console.log pipeline
        Rp_Ratings.aggregate(pipeline)

      getRatingResultsSummary:(qry)->
        check(qry,Object)
        pipeline=_pipeline(qry)
        pipeline.push($group:{_id:null,avgValue:{$avg:"$value"}})
        Rp_Ratings.aggregate(pipeline)



      getRatingTotalVotes:(qry)->
        check(qry,Object)
        pipeline=[
          {$match:qry}
          {$group:{_id : null,totalCount: { $sum: 1 }}}
        ]
        Rp_Ratings.aggregate(pipeline)

      getRatingItem:(qry={},modifier={})->
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

  getRatings:(qry={},modifier={})->
    Rp_Ratings.find(qry,modifier)

Rp_Rating=new Rp_Rating_Server()
