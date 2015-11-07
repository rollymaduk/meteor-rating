Template.body.rendered=->
  view=Blaze.toHTML(Template.rp_rating_modal)
  $(view).appendTo("body")
  $('#rp_rating_modal').on('hidden.bs.modal', ()->
    if Rp_Rating.modalHandle then Blaze.remove(Rp_Rating.modalHandle)
  )