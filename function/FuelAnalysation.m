function Con = FuelAnalysation(RawData,fuelprop)
    Con.B7 = FuelAnalys(RawData, fuelprop.CalorificValue(1), "B7");
    Con.B7DPF = FuelAnalys(RawData, fuelprop.CalorificValue(1), "B7withDPF");
    Con.B100 = FuelAnalys(RawData, fuelprop.CalorificValue(2), "B100");
    Con.B100DPF = FuelAnalys(RawData, fuelprop.CalorificValue(2), "B100withDPF");
end

function NewTable = FuelAnalys(RawData,fuelprop, fuel)
    NewTable = table(RawData.RPM, RawData.Torque, RawData.BrakePower, RawData.(fuel));
    NewTable.Properties.VariableNames = [RawData.Properties.VariableNames(1:2) "Brake Power [kW]" "Fuel comsumption [g/s]"];
    NewTable.("Qin [kW]") = NewTable.("Fuel comsumption [g/s]") * fuelprop;
    NewTable.("BSFC [g/kWh]") = NewTable.("Fuel comsumption [g/s]") ./ NewTable.("Brake Power [kW]") * 3600;
    NewTable.("BSEC [kJ/kWh]") = NewTable.("BSFC [g/kWh]") * fuelprop;
    NewTable.("BTE [%]") = NewTable.("Brake Power [kW]") ./ NewTable.("Qin [kW]") * 100;
end