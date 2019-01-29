function test2(Channel, pauseTime)
    test(Channel, [0 0], 1)
    for i=[1:9 8:-1:0]
        %fprintf ('%f\n', i)
        test(Channel, [i i], 0)
        pause(pauseTime)
    end