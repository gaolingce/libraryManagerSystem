package com.system.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class IDUtil {

    private static String FORMAT_DAY = "yyyy-MM-dd";

    //编号自动生成
    public static String createId(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyddMMhhmmss");
        return (sdf.format(new Date()));
    }

    public static String checkStockId(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyddMMhhmmss");
        return (sdf.format(new Date())).substring(6,14);
    }

    //获取当前时间
    public static String getNowTime(){
        Date date = new Date();//获取当前的日期
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String str = df.format(date);//
        return str;
    }

    //获得当前时间之后30天的时间
    public static String getThirtyDay(){
        Date date=new   Date();//取时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        Calendar calendar   =   new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DAY_OF_MONTH,30);//把日期往后增加一天.整数往后推,负数往前移动
        //calendar.add(calendar.YEAR, 1);//把日期往后增加一年.整数往后推,负数往前移动
        //calendar.add(calendar.DAY_OF_MONTH, 1);//把日期往后增加一个月.整数往后推,负数往前移动
        //calendar.add(calendar.WEEK_OF_MONTH, 1);//把日期往后增加一个月.整数往后推,负数往前移动
        date=calendar.getTime();   //这个时间就是日期往后推一天的结果
        String format  = sdf.format(date);

        return format;
    }

    //计算时间差


    /**
     *  计算得到时间差，单位：天   注：不含结束日期  2019-02-21~2019-02-23  结果2
     * @param startDate 开始日期
     * @param endDate  结束日期
     * @return
     */
    public static int dateDifference(String startDate, String endDate)   {
        Date d1 = conversionToDate(startDate,FORMAT_DAY);
        Date d2 = conversionToDate(endDate,FORMAT_DAY);
        long dateDifference = d2.getTime() - d1.getTime();
        long nd = 1000 * 24 * 60 * 60;
        return (int)(dateDifference / nd);
    }

    //格式化时间
    public static Date conversionToDate(String date, String format){
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date d = null;
        try {
            d = sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return d;
    }

}
