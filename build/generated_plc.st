PROGRAM prueba
  VAR
    sensor_hall AT %IX0.0 : BOOL := 0;
    led AT %QX0.0 : BOOL := 1;
    rele AT %QX0.1 : BOOL := 0;
  END_VAR
  VAR
    TP0 : TP;
    counter : CTU;
    TON0 : TON;
    TP1 : TP;
    _TMP_NOT10_OUT : BOOL;
    R_TRIG1 : R_TRIG;
    _TMP_NOT16_OUT : BOOL;
  END_VAR

  _TMP_NOT10_OUT := NOT(sensor_hall);
  R_TRIG1(CLK := _TMP_NOT10_OUT);
  counter(CU := R_TRIG1.Q, R := TON0.Q, PV := 5);
  TON0(IN := counter.Q, PT := T#10000ms);
  led := TON0.Q;
  TP0(IN := counter.Q, PT := T#2000ms);
  TP1(IN := TON0.Q, PT := T#2000ms);
  rele := TP0.Q OR TP1.Q;
  _TMP_NOT16_OUT := NOT(counter.Q);
  led := _TMP_NOT16_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : prueba;
  END_RESOURCE
END_CONFIGURATION
