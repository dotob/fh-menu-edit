Array.prototype.move = (element, offset) ->
  index = this.indexOf(element)
  newIndex = index + offset
  
  if newIndex > -1 && newIndex < this.length
    # Remove the element from the array
    removedElement = this.splice(index, 1)[0]
  
    # At "newIndex", remove 0 elements, insert the removed element
    this.splice(newIndex, 0, removedElement)