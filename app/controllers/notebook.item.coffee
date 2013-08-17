Spine = require 'spine'

# Models
Notebook = require '../models/notebook.coffee'

class NotebookItem extends Spine.Controller
  elements:
    "ul": "category"

  events:
    "click": "expand"
    "click .icon": "newCategory"

  constructor: ->
    super
    @notebook.bind "changeNotebook", @changeNotebook
    @notebook.bind "update", @update

  expand: (e) =>
    # Categories
    if $(e.target).attr("data-category")
      Notebook.trigger("changeNotebook", {id: @notebook.id, category: $(e.target).attr("data-category")})
    else
      Notebook.trigger("changeNotebook", {id: @notebook.id, category: "all"})

  changeNotebook: (notebook) =>
    # This is seperated because we don't want to do DOM triggers.
    @el.parent()
      .children()
      .removeClass('expanded selected')
    @el.addClass('selected')

    # Only show the categories if there's more than one.
    @el.addClass('expanded') if @notebook.categories.length > 1

    # Select the right one
    @category.find("li").removeClass('selected')
    @el.find("[data-category='#{notebook.category}']").addClass("selected")

  newCategory: (e) ->
    $(".popover-mask").show()
    target = $(e.target).parent()

    $(".category-popover").css({left: target.outerWidth(), top: target.offset().top}).show()
      .find("input").val('').focus()

  update: =>
    # Subcategories
    str = "<li data-category='all' class='selected'>All Notes</li>"
    for category, i in @notebook.categories
      str += "<li data-category=" + i + ">" + category + "</li>"
    @category.html(str)

    @el.addClass('expanded') if @notebook.categories.length > 1

module.exports = NotebookItem
