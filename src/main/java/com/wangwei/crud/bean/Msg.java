package com.wangwei.crud.bean;

import java.util.HashMap;
import java.util.Map;

/*这个里面使用到了链式存储思想，很强，也很厉害，这个老师真牛。*/
/**这个就是通用的返回类。
 * 用来返回信息的，并返回json数据
 * @author WangWei
 * @create 2021-09-27 18:04
 */
public class Msg {
    /*这个既可以判断成功也能判断是否失败
    * 100--成功   200--失败*/
    private int code;
    private String msg;

    private Map<String,Object> extend = new HashMap<>();

    /*添加两个静态方法，用来设置信息的*/
    /*1.成功的方法调用*/

    public static Msg fail(){
        Msg fail = new Msg();
        fail.setCode(200);
        fail.setMsg("请求失败！！");
        return fail;
    }

    public static Msg success(){
        Msg success = new Msg();
        success.setCode(100);
        success.setMsg("请求成功！！");
        return success;
    }

    /*定义一个链式发返回方式*/
    public Msg add(String key,Object obj){
        this.getExtend().put(key,obj);
        return this;
    }



    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
