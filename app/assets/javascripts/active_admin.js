//= require active_admin/base

$(document).ready( function() {
  $('body.admin_items #item_category_id').change(function() {
    location.href = '?category_id=' + this.value;
  })
})
