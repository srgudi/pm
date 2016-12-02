package com.chiguru.pm.crm.util;

import com.chiguru.pm.crm.dto.KeyValue;

import java.io.Serializable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class PMConstants implements Serializable {
    public static final KeyValue MONTH_JAN = new KeyValue("Jan", "0");
    public static final KeyValue MONTH_FEB = new KeyValue("Feb", "1");
    public static final KeyValue MONTH_MAR = new KeyValue("Mar", "2");
    public static final KeyValue MONTH_APR = new KeyValue("Apr", "3");
    public static final KeyValue MONTH_MAY = new KeyValue("May", "4");
    public static final KeyValue MONTH_JUN = new KeyValue("Jun", "5");
    public static final KeyValue MONTH_JUL = new KeyValue("Jul", "6");
    public static final KeyValue MONTH_AUG = new KeyValue("Aug", "7");
    public static final KeyValue MONTH_SEP = new KeyValue("Sep", "8");
    public static final KeyValue MONTH_OCT = new KeyValue("Oct", "9");
    public static final KeyValue MONTH_NOV = new KeyValue("Nov", "10");
    public static final KeyValue MONTH_DEC = new KeyValue("Dec", "11");
    public static final String DUE_MONTH_QUARTER_1 = "Due Month Quarter 1";
    public static final String DUE_DAY_QUARTER_1 = "Due Day Quarter 1";
    public static final String DUE_MONTH_QUARTER_2 = "Due Month Quarter 2";
    public static final String DUE_DAY_QUARTER_2 = "Due Day Quarter 2";
    public static final String DUE_MONTH_QUARTER_3 = "Due Month Quarter 3";
    public static final String DUE_DAY_QUARTER_3 = "Due Day Quarter 3";
    public static final String DUE_MONTH_QUARTER_4 = "Due Month Quarter 4";
    public static final String DUE_DAY_QUARTER_4 = "Due Day Quarter 4";
    public static final String DUE_MONTH_1 = "Due Month 1";
    public static final String DUE_DAY_1 = "Due Day 1";
    public static final String DUE_MONTH_2 = "Due Month 2";
    public static final String DUE_DAY_2 = "Due Day 2";
    public static final String DUE_MONTH_3 = "Due Month 3";
    public static final String DUE_DAY_3 = "Due Day 3";
    public static final String DUE_MONTH_4 = "Due Month 4";
    public static final String DUE_DAY_4 = "Due Day 4";
    public static final String DUE_MONTH = "Due Month";
    public static final String DUE_DAY = "Due Day";
    public static final int MAX_FREQUENCY_COUNT = 4;
    public static List<KeyValue> MONTHLIST = new ArrayList<KeyValue>();
    public static List<String> DUE_DAY_LIST_QUARTER = new ArrayList<String>();
    public static List<String> DUE_MONTH_LIST_QUARTER = new ArrayList<String>();
    public static List<String> DUE_DAY_LIST_SEMI_YEARLY = new ArrayList<String>();
    public static List<String> DUE_MONTH_LIST_SEMI_YEARLY = new ArrayList<String>();
    public static List<String> DUE_DAY_LIST_YEARLY = new ArrayList<String>();
    public static List<String> DUE_MONTH_LIST_YEARLY = new ArrayList<String>();
    public static List<String> DUE_DAY_LIST_MONTHLY = new ArrayList<String>();
    public static List<KeyValue> YES_NO_LIST = new ArrayList<KeyValue>();
    public static final int LAST_DAY_OF_THE_MONTH = -100;
    public static Map DUE_DAY_LABEL_MAP = new HashMap();
    public static final Integer OFFICE_PHONE = 3;
    public static final Integer MOBILE_PHONE = 5;
    public static final Integer HOME_PHONE = 4;
    public static final Integer OTHER_PHONE = 6;
    public static final Integer ORDINARY_SHARE = 1;
    public static final Integer PREFERRED_SHARE = 2;
    public static final Integer OTHER_SHARE = 3;
    public static final KeyValue OFFICE_PHONE_TYPE = new KeyValue("Office",
            OFFICE_PHONE.toString());
    public static final KeyValue HOME_PHONE_TYPE = new KeyValue("Home",
            HOME_PHONE.toString());
    public static final KeyValue MOBILE_PHONE_TYPE = new KeyValue("Mobile",
            MOBILE_PHONE.toString());
    public static final KeyValue OTHER_PHONE_TYPE = new KeyValue("Other",
            OTHER_PHONE.toString());
    public static List<KeyValue> PHONE_TYPE_LIST = new ArrayList<KeyValue>();

    public static final KeyValue ORDINARY_SHARE_TYPE = new KeyValue("Ordinary",
    		ORDINARY_SHARE.toString());
    public static final KeyValue PREFERRED_SHARE_TYPE = new KeyValue("Preferred",
    		PREFERRED_SHARE.toString());
    public static final KeyValue OTHER_SHARE_TYPE = new KeyValue("Other",
    		OTHER_SHARE.toString());
    
    public static List<KeyValue> SHARE_TYPE_LIST = new ArrayList<KeyValue>();
    static {
        //initialize month list
        MONTHLIST.add(PMConstants.MONTH_JAN);
        MONTHLIST.add(PMConstants.MONTH_FEB);
        MONTHLIST.add(PMConstants.MONTH_MAR);
        MONTHLIST.add(PMConstants.MONTH_APR);
        MONTHLIST.add(PMConstants.MONTH_MAY);
        MONTHLIST.add(PMConstants.MONTH_JUN);
        MONTHLIST.add(PMConstants.MONTH_JUL);
        MONTHLIST.add(PMConstants.MONTH_AUG);
        MONTHLIST.add(PMConstants.MONTH_SEP);
        MONTHLIST.add(PMConstants.MONTH_OCT);
        MONTHLIST.add(PMConstants.MONTH_NOV);
        MONTHLIST.add(PMConstants.MONTH_DEC);

        //initialize the due day list
        DUE_DAY_LIST_QUARTER.add(DUE_DAY_QUARTER_1);
        DUE_DAY_LIST_QUARTER.add(DUE_DAY_QUARTER_2);
        DUE_DAY_LIST_QUARTER.add(DUE_DAY_QUARTER_3);
        DUE_DAY_LIST_QUARTER.add(DUE_DAY_QUARTER_4);

        DUE_MONTH_LIST_QUARTER.add(DUE_MONTH_QUARTER_1);
        DUE_MONTH_LIST_QUARTER.add(DUE_MONTH_QUARTER_2);
        DUE_MONTH_LIST_QUARTER.add(DUE_MONTH_QUARTER_3);
        DUE_MONTH_LIST_QUARTER.add(DUE_MONTH_QUARTER_4);

        DUE_DAY_LIST_SEMI_YEARLY.add(DUE_DAY_1);
        DUE_MONTH_LIST_SEMI_YEARLY.add(DUE_MONTH_1);
        DUE_DAY_LIST_SEMI_YEARLY.add(DUE_DAY_2);
        DUE_MONTH_LIST_SEMI_YEARLY.add(DUE_MONTH_2);

        DUE_DAY_LIST_YEARLY.add(DUE_DAY);
        DUE_MONTH_LIST_YEARLY.add(DUE_MONTH);

        DUE_DAY_LIST_MONTHLY.add(DUE_DAY);

        DUE_DAY_LABEL_MAP.put("DUE_DAY_LIST_YEARLY", DUE_DAY_LIST_YEARLY);
        DUE_DAY_LABEL_MAP.put("DUE_MONTH_LIST_YEARLY", DUE_MONTH_LIST_YEARLY);

        DUE_DAY_LABEL_MAP.put("DUE_DAY_LIST_SEMI_YEARLY",
            DUE_DAY_LIST_SEMI_YEARLY);
        DUE_DAY_LABEL_MAP.put("DUE_MONTH_LIST_SEMI_YEARLY",
            DUE_MONTH_LIST_SEMI_YEARLY);

        DUE_DAY_LABEL_MAP.put("DUE_DAY_LIST_QUARTER", DUE_DAY_LIST_QUARTER);
        DUE_DAY_LABEL_MAP.put("DUE_MONTH_LIST_QUARTER", DUE_MONTH_LIST_QUARTER);

        DUE_DAY_LABEL_MAP.put("DUE_DAY_LIST_MONTHLY", DUE_DAY_LIST_MONTHLY);

        YES_NO_LIST.add(new KeyValue("Yes", Boolean.TRUE.toString()));
        YES_NO_LIST.add(new KeyValue("No", Boolean.FALSE.toString()));

        PHONE_TYPE_LIST.add(PMConstants.OFFICE_PHONE_TYPE);
        PHONE_TYPE_LIST.add(PMConstants.HOME_PHONE_TYPE);
        PHONE_TYPE_LIST.add(PMConstants.MOBILE_PHONE_TYPE);
        PHONE_TYPE_LIST.add(PMConstants.OTHER_PHONE_TYPE);
        
        SHARE_TYPE_LIST.add(PMConstants.ORDINARY_SHARE_TYPE);
        SHARE_TYPE_LIST.add(PMConstants.PREFERRED_SHARE_TYPE);
        SHARE_TYPE_LIST.add(PMConstants.OTHER_SHARE_TYPE);
    }
    
    //Add Dashboard constants
    public static final int MISSED_DEADLINE = 0;
    public static final int TODAY_DEADLINE = 1;
    public static final int SEVEN_DAY_RANGE = 7;
    public static final int THIRTY_DAY_RANGE = 30;
    public static final int SIXTY_DAY_RANGE = 60;
    public static final int NINETY_DAY_RANGE = 90;
    public static final int WAITING_STATUS = 180;
}
