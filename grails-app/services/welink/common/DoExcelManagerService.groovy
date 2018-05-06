package welink.common

import grails.transaction.Transactional
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem

import java.lang.reflect.Field
import java.text.DecimalFormat
import java.text.SimpleDateFormat

@Transactional
class DoExcelManagerService {


    static final SimpleDateFormat TIMEFORMAT=new SimpleDateFormat("yyyyMMddHHmmss");
    static final String FSPLIT=File.separator


    def buildERPModelExcel(def list,String path,String fileName,String[] titleArr,String[] paramsArr){
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet(fileName);
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        for(int i=0;i<titleArr.size();i++){
            HSSFCell  cell = row.createCell((short) i);
            cell.setCellValue(titleArr[i]);
            cell.setCellStyle(style);
        }
        for (int i = 0; i < list.size(); i++) {
            row = sheet.createRow((int) i + 1);
            def detail= list.get(i);
            //属性值虽然很多，但是打印好对应有title值就可以了
            for(int j=0;j<titleArr.length;j++){
                // 第四步，创建单元格，并设置值
                Object obj=getParamValue(detail,paramsArr[j])
                row.createCell((short) j).setCellValue((!("null".equals(obj)))?obj:"");
            }
        }
        // 第六步，将文件存到指定位置
        try
        {
            String finalfileName=path+FSPLIT+fileName+TIMEFORMAT.format(new Date())+".xls"
            FileOutputStream fout = new FileOutputStream(finalfileName);
            wb.write(fout);
            fout.close();
            return finalfileName;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }


    //根据对应的class值来获取对应的value值
    def getParamValue(def detail,String name){
        Object value="";
        //得到类对象
        Class userCla = (Class) detail.getClass();
        /*
	     * 得到类中的所有属性集合
	     */
        Field[] fs = userCla.getDeclaredFields();
        for(int i = 0 ; i < fs.length; i++){
            Field f = fs[i];
            f.setAccessible(true); //设置些属性是可以访问的
            if(f.getName().equals(name)){
                Object val = f.get(detail);//得到此属性的值
                value=val.toString()
                break
            }
        }
        return value
    }


    def getOneObjParamsValue(def detail){
        //得到类对象
        Class userCla = (Class) detail.getClass();
        /*
	     * 得到类中的所有属性集合
	     */
        Field[] fs = userCla.getDeclaredFields();
        String[] arr=new String[fs.length]
        for(int i = 0 ; i < fs.length; i++){
            Field f = fs[i];
            f.setAccessible(true); //设置些属性是可以访问的
            arr[i]=f.getName()
        }
        return  arr
    }




    //读入的EXCEL
    String[] readExcelTitle(InputStream is)
    {
        def POIFSFileSystem fs;
        def HSSFWorkbook wb;
        def HSSFSheet sheet;
        def HSSFRow row;

        try {
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        row = sheet.getRow(0);
        // 标题总列数
        int colNum = row.getPhysicalNumberOfCells();
        System.out.println("colNum:" + colNum);
        String[] title = new String[colNum];
        for (int i = 0; i < colNum; i++) {
            title[i] = getCellFormatValue(row.getCell((short) i));
        }
        return title;
    }



    String getCellFormatValue(HSSFCell cell)
    {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
            // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC:
                case HSSFCell.CELL_TYPE_FORMULA:
                    DecimalFormat df =new DecimalFormat("0");
//                    String str=df.format(cell.getNumericCellValue());
                    //不转为科学计算法
                    cellvalue = df.format(cell.getNumericCellValue());
//                    cellvalue = (cell.getNumericCellValue()).toString();
//                    cellvalue = String.valueOf(cell.getNumericCellValue());
                    break;
            // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getRichStringCellValue().getString();
                    break;
            // 默认的Cell值
                default:
                    cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;
    }



    /**
     * 获取单元格数据内容为字符串类型的数据
     *
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                strCell = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                strCell = String.valueOf(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                strCell = String.valueOf(cell.getBooleanCellValue());
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                strCell = "";
                break;
            default:
                strCell = "";
                break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        if (cell == null) {
            return "";
        }
        return strCell;
    }



    /**
     * 读取Excel数据内容
     * @param InputStream
     * @return Map 包含单元格数据内容的Map对象
     */
    Map<Integer, String> readExcelContent(InputStream is)
    {
        def POIFSFileSystem fs;
        def HSSFWorkbook wb;
        def HSSFSheet sheet;
        def HSSFRow row;
        Map<Integer, String> content = new HashMap<Integer, String>();
        String str = "";
        try {
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        // 得到总行数
        int rowNum = sheet.getLastRowNum();
        row = sheet.getRow(0);
        int colNum = row.getPhysicalNumberOfCells();
        // 正文内容应该从第二行开始,第一行为表头的标题
        for (int i = 1; i <= rowNum; i++) {
            row = sheet.getRow(i);
            int j = 0;
            while (j < colNum) {
                // 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
                // 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
                // str += getStringCellValue(row.getCell((short) j)).trim() +
                // "-";
                String loc=getCellFormatValue(row.getCell((short) j)).trim();

                if ("".equals(loc))
                {
                    str +="  "+ "##";
                }
                else{
                    str +=loc+ "##";
                }
                j++;
            }
            content.put(i, str);
            str = "";
        }
        return content;
    }



}
