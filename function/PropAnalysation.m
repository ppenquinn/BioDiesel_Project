function Properties = PropAnalysation(Fuel)
    Properties.FuelConsum = Property(Fuel, "Fuel comsumption [g/s]");
    Properties.Qin = Property(Fuel, "Qin [kW]");
    Properties.BSFC = Property(Fuel, "BSFC [g/kWh]");
    Properties.BSEC = Property(Fuel, "BSEC [kJ/kWh]");
    Properties.BTE = Property(Fuel, "BTE [%]");
end


function NewTable = Property(Fuel, prop)
    % for DPF condition
    % NewTable = table(Fuel.B7.RPM, Fuel.B7.Torque, Fuel.B7.(prop), Fuel.B7DPF.(prop), Fuel.B100.(prop), Fuel.B100DPF.(prop));
    % NewTable.Properties.VariableNames = ["RPM" "Torque" "B7" "B7withDPF" "B100" "B100withDPF"];
    NewTable = table(Fuel.B7.RPM, Fuel.B7.Torque, Fuel.B7.(prop), Fuel.B100.(prop));
    NewTable.Properties.VariableNames = ["RPM" "Torque" "B7" "B100"];
end