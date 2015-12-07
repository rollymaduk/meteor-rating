Template.registerHelper 'rp_rating_identity',(user)->
  ids=(for item in Rp_Rating.identityFields
    do (item)->
      res=item.split('.')
      res.unshift(user)
      res
  )
  (Meteor._get.apply null,identity for identity in ids).join(" ")