function t = ft_bar(Table, prop)
    torque_values = ["84 Nm", "112 Nm", "140 Nm", "160 Nm"];
    x = [1-0.25 1+0.25 2-0.25 2+0.25 3-0.25 3+0.25 4-0.25 4+0.25];
    rpm_values = [1500, 2000, 2500];
    Ary = table2array(Table);
    ylim = max(max(Ary(:,3:end)));
    t = tiledlayout(1, 3,'TileSpacing','none');
    for i = 1:3
        nexttile;
        if i == 1
            T = Table{1:4, 3:end};
        elseif i == 2
            T = Table{5:8, 3:end};
        else
            T = Table{9:12, 3:end};
        end
        y_label = prop ;
        if prop == "BSEC [kJ/kWh]"
            T = T/1000;
            if i == 1
                ylim = ylim/1000;
            end
            y_label = y_label + " (x10^4)";
        end
        y_txt = [T(1, :) T(2, :) T(3, :) T(4, :)];
        txt = strsplit(sprintf('%.3g\n', y_txt(:)), '\n');
        b_plot = bar(T, 1, 'hist');
        %change Color of Bar plot
        b_plot(1).FaceColor = '#EA3323';
        b_plot(2).FaceColor = '#00007E';
        %texting above the bar
        text(x, y_txt, txt(1:length(x)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',8);
        xtick_positions = 1:(length(torque_values) * length(rpm_values));
        xticks(xtick_positions);
        xticklabels(torque_values);
        xlabel([num2str(rpm_values(i)), ' RPM']);
        xlim([0, length(torque_values) + 1]);
        
        if i == 1
            yyaxis right
            ax = gca();
            ax.YAxis(2).Color = 'none';
            yyaxis left
            ylabel(y_label);
            ax.YLim = [0 (ylim + 0.1 * ylim)];
            legend(Table.Properties.VariableNames(3:end), "Location", "northwest");
            
        elseif i== 3
            yyaxis left
            ax = gca();
            ax.YLim = [0 (ylim + 0.1 * ylim)];
            ax.YAxis(1).Visible = "off";
            yyaxis right
            ax.YLim = [0 (ylim + 0.1 * ylim)];
            ax.YAxis(2).Color = 'black';
        else
            ax = gca();
            ax.YAxis.Visible = "off";
            ax.YLim = [0 (ylim + 0.1 * ylim)];
        end
        ax.LineWidth = 1.5;
        grid on
    end
    t.Padding = 'compact';
    title(t, prop);
end
