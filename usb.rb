require 'green_shoes'

Shoes.app title: 'USB', width: 530, height: 400 do
  para 'Input device', margin: 15
  @line = edit_line width: 370, margin: 15
  @eject_button = button 'Eject device', margin: 15, width: 40
  @button = button 'Device list', margin: 15, margin_left: 220
  @edit_box = edit_box margin: 20, width: 480, height: 150

  @button.click do

    Thread.new do
      loop do

        @other = `lsusb -v`
        @other.split("\n").each do |item|
          if item.include?('iProduct') and item.split(' ').size == 5
            @edit_box.text += "#{item.split(' ')[2]} #{item.split(' ')[3]} #{item.split(' ')[4]}"
          end
        end
        memory = `df -h`
        media = `ls /media/*`
        media.split("\n").each do |device|
          memory.split("\n").each do |memory|
            if memory.include?device
              @edit_box.text += device + "\n"
              @edit_box.text += "Size is: #{memory.split(' ')[1]}\n"
              @edit_box.text += "Used memory: #{memory.split(' ')[2]}\n\n"
            end
          end
        end

        sleep 5
      end
    end

  end

  @eject_button.click do
    memory = `df -h`
    memory.split("\n").each do |memory|
      if memory.include?@line.text
        `umount #{memory.split(' ')[0]}`
      end
    end
  end
end