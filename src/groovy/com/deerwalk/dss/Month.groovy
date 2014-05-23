package com.deerwalk.dss
/**
 * Created with IntelliJ IDEA.
 * User: sagurung
 * Date: 9/10/13
 * Time: 6:51 PM
 * To change this template use File | Settings | File Templates.
 */
public enum Month {
    Jan('January'),
    Feb('February'),
    Mar('March'),
    Apr('April'),
    May('May'),
    Jun('June'),
    Jul('July'),
    Aug('August'),
    Sep('September'),
    Oct('October'),
    Nov('November'),
    Dec('December');

    String value
    Month(String value){
        this.value=value
    }
    public String getValue(){value;}
}