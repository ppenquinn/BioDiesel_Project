function avg_volume = ft_average(gas_value, time)
    index = find(time(1) <= gas_value(:, 1) & gas_value(:, 1) <= time(2));
    Vrange = gas_value(index, 2);
    avg_volume = mean(Vrange);
end