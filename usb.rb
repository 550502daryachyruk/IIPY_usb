require 'green shoes'
gef gui
  Shoes.app title: 'USB', width: 450, height: 450 do
    $list_box = edit_listbox
    $flow = edit_flow :margin => 3 do
      inscription 'name: '
      @username = edit_line :width => 200, :text => '*'
    end
    $item = button 'show devices', margin: 10
    $item.click do
      @username = edit_line 'err', margin: 5
    end

  end