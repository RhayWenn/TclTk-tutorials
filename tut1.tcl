#Pacotes##########################################################
package require BWidget
#Seção de Configuração###########################################
toplevel .main -height 300.0 -width 300.0 -background #FFFFFF
wm title .main "Gas-Vapor Properties Calculator"
wm resizable .main 0 0
wm geometry .main 300x300+350+250
labelframe .main.lfr1 -width 300.0 -height 100.0 -text "PVT Interface" -background #C0C0C0
labelframe .main.lfr2 -width 300.0 -height 100.0 -text "Antoine Equation" -background #C0C0C0
labelframe .main.lfr3 -width 300.0 -height 100.0 -text "Help" -background #C0C0C0
button .main.lfr1.b1 -text "Calculate" -background #696969 -command { pvtProc $input1 $input2 $varpvt }
label .main.lfr1.lb1 -text "Pressure (atm)" -background #C0C0C0
label .main.lfr1.lb2 -text "Temperature (K)" -background #C0C0C0
label .main.lfr1.lb3 -text "Calculated Density (L/mol)" -background #C0C0C0 -foreground #ff0000
label .main.lfr1.lb4 -text "0.0000" -background #FFFFFF -foreground #0000ff -width 10
label .main.lfr1.lb5 -text "Choose Output Variable" -background #C0C0C0
global input1 input2
set input1 1.0
set input2 273.15
entry .main.lfr1.e1 -width 7 -textvariable input1
entry .main.lfr1.e2 -width 7 -textvariable input2
ComboBox .main.lfr1.combopvt -editable false -state normal -values {"Density" "Pressure" "Temperature"} -textvariable varpvt -width 18 -modifycmd {cbTest $varpvt} 
#Seção de Geração de Widgets########################################
place .main.lfr1 -x 0.0 -y 0.0
place .main.lfr2 -x 0.0 -y 100.0
place .main.lfr3 -x 0.0 -y 200.0
place .main.lfr1.b1 -x 180.0 -y 50.0
place .main.lfr1.lb1 -x 60.0 -y 40.0
place .main.lfr1.lb2 -x 60.0 -y 60.0
place .main.lfr1.lb3 -x 143.0 -y 8.0
place .main.lfr1.lb4 -x 173.0 -y 25.0
place .main.lfr1.lb5 -x 5.0 -y 0.0
place .main.lfr1.e1 -x 5.0 -y 40.0
place .main.lfr1.e2 -x 5.0 -y 60.0
place .main.lfr1.combopvt -x 5.0 -y 18.0
#Seção de Procedures###################################################
proc cbTest {varpvt} {
    if { $varpvt == "Density" } {
        .main.lfr1.lb1 configure -text "Pressure (atm)"
        .main.lfr1.lb2 configure -text "Temperature (K)"
        .main.lfr1.lb3 configure -text "Calculated Density (L/mol)"
    } elseif { $varpvt == "Temperature" } {
            .main.lfr1.lb1 configure -text "Density (L/mol)"
            .main.lfr1.lb2 configure -text "Pressure (atm)"
            .main.lfr1.lb3 configure -text "Calculated Temperature (K)"
    
    } elseif { $varpvt == "Pressure" } {
            .main.lfr1.lb1 configure -text "Density (L/mol)"
            .main.lfr1.lb2 configure -text "Temperature (K)"
            .main.lfr1.lb3 configure -text "Calculated Pressure (atm)"
    } else {
        return
    }
}
proc pvtProc { in1 in2 flag } {
    if { $flag == "Density" } {
        set result [expr { $in1 / ( $in2 * 0.082 )} ]
        .main.lfr1.lb4 configure -text "[format "%.4f"  $result]"
    } elseif { $flag == "Pressure" } {
        set result [expr { $in1 * $in2 * 0.082 } ]
        .main.lfr1.lb4 configure -text "[format "%.4f"  $result]"
    } else {
        set result [expr { $in2 / ( $in1 * 0.082 ) } ]
        .main.lfr1.lb4 configure -text "[format "%.4f"  $result]"
    }
}
###################################################################################################
###################################################################################################
#Antoine Pannel
###################################################################################################
###################################################################################################
#Configuration section
label .main.lfr2.lb1 -text "Choose Output Variable/Chemical" -background #C0C0C0 -font "Times 8"
label .main.lfr2.lb2 -text "Temperature (°C)" -background #C0C0C0 -font "Times 8"
label .main.lfr2.lb3 -text "Calculated Psat (mmHg)" -background #C0C0C0 -foreground #ff0000 -font "Times 8"
label .main.lfr2.lb4 -text "0.00" -background #FFFFFF -foreground #0000FF -width 10 -font "Times 8"
entry .main.lfr2.e1 -textvariable input3 -width 7 -font "Times 8"
ComboBox .main.lfr2.comboant -editable false -state normal -values {"Pressure" "Temperature"} -textvariable varant -width 18 -height 2 -modifycmd {cbTestt $varant} -font "Times 8"
ComboBox .main.lfr2.comboant2 -editable false -state normal -values {"Water" "Ethanol" "Acetic Acid" "Ketone"} -textvariable varchem -width 18 -height 2 -modifycmd {chemSel $varchem} -font "Times 8"
button .main.lfr2.b1 -text "Calculate" -command {antProc $input3 $varant} -background #696969 -font "Times 8"
#Variables Section
global ana anb anc
set input3 25.00
#Parametros para agua
set ana 8.07131
set anb 1730.63
set anc 233.426
#place###############################################################################################
place .main.lfr2.comboant -x 5.0 -y 18.0
place .main.lfr2.comboant2 -x 5.0 -y 40.0
place .main.lfr2.lb1 -x 5.0 -y 0.0
place .main.lfr2.e1 -x 5.0 -y 60.0
place .main.lfr2.lb2 -x 60.0 -y 60.0
place .main.lfr2.lb3 -x 169.0 -y 8.0
place .main.lfr2.lb4 -x 193.0 -y 25.0
place .main.lfr2.b1 -x 200.0 -y 50.0
#Procedures Section####################################################################3
proc cbTestt { varant } {
    if { $varant == "Temperature"} {
        .main.lfr2.lb2 configure -text "Pressure (mmHg)"
        .main.lfr2.lb3 configure -text "Calculated Tsat (ºC)"        
    } elseif {$varant == "Pressure"} {
        .main.lfr2.lb2 configure -text "Temperature (ºC)"
        .main.lfr2.lb3 configure -text "Calculated Psat (mmHg)"
    }
    return
}
proc chemSel { varchem } {
    global ana anb anc
    if { $varchem == "Water" } {
        set ana 8.07131
        set anb 1730.63
        set anc 233.426
    } elseif { $varchem == "Ethanol" } {
        set ana 8.20417
        set anb 1642.89
        set anc 230.300
    } elseif { $varchem == "Acetic Acid" } {
        set ana 7.18807
        set anb 1416.70
        set anc 211.00
    } elseif { $varchem == "Ketone" } {
        set ana 7.02447
        set anb 1161.00
        set anc 224.00
    }
    return
}
proc antProc { in3 flag } {
    global ana anb anc
    set output 0.0
    if { $flag == "Temperature" } {
        #Tsat Calculation
        set output [expr { ($anb / ( $ana - log10($in3) )) - $anc }]
        .main.lfr2.lb4 configure -text "[format "%.4f" $output]"
        return
    } elseif { $flag == "Pressure" } {
        #Psat Calculation
        set output [expr { pow(10,($ana - ($anb / ($anc + $in3)))) }]
        .main.lfr2.lb4 configure -text "[format "%.4f" $output]"
        return
    }
}
###################################################################################################
###################################################################################################
#Help Pannel
###################################################################################################
###################################################################################################
#Configuration section
image create photo .whatpic -format GIF -file F:/TclTk/excl.gif
image create photo .whatpic2 -format GIF -file F:/TclTk/excl2.gif
button .main.lfr3.b2 -text "What is PVT?" -command {help1Proc} -background #00a2e8 -font "Times 7" -image .whatpic -compound top
button .main.lfr3.b1 -text "What is Antoine Eq.?" -command {help2Proc} -background #00e84c -font "Times 7" -image .whatpic2 -compound bottom
#Place####################################################################################3
place .main.lfr3.b2 -x 5.0 -y 0.0
place .main.lfr3.b1 -x 70.0 -y 0.0
#Procedure Section################################################################3
proc help1Proc {} {
    toplevel .helppvt -height 600.0 -width 600.0 -background #5f6661
    wm title .helppvt "What is PVT?"
    wm resizable .helppvt 0 0
    wm geometry .helppvt 600x600+350+250
    raise .helppvt
    canvas .helppvt.cv -height 600.0 -width 600.0 -background #FFFFFF
    image create photo .helppvt.cv.pvtpic -format GIF -file F:/TclTk/pvt.gif
    .helppvt.cv create image 300 300 -image .helppvt.cv.pvtpic
    place .helppvt.cv -x 0.0 -y 0.0    
}
proc help2Proc {} {
    toplevel .helpant -height 450.0 -width 700.0 -background #5f6661
    wm title .helpant "What is Antoine Eq.?"
    wm resizable .helpant 0 0
    wm geometry .helpant 700x450+350+250
    raise .helpant
    canvas .helpant.cv -height 450.0 -width 700.0 -background #FFFFFF
    image create photo .helpant.cv.pvtpic -format GIF -file F:/TclTk/antoine.gif
    .helpant.cv create image 350 225 -image .helpant.cv.pvtpic
    place .helpant.cv -x 0.0 -y 0.0    
}




















