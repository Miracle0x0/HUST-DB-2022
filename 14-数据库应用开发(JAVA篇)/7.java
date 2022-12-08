import java.sql.*;

public class Transform {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/sparsedb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123123";

    /**
     * 向 sc 表中插入数据
     * 
     * @param {Connection} connection 数据库连接对象
     * @param {int}        sno 学号
     * @param {String}     col_name 课程名
     * @param {int}        col_value 课程成绩
     */
    public static int insertSC(Connection connection, int sno, String col_name, int col_value) {
        String sql = "insert into sc values (?, ?, ?);";
        try {
            PreparedStatement pps = connection.prepareStatement(sql);
            pps.setInt(1, sno);
            pps.setString(2, col_name);
            pps.setInt(3, col_value);
            pps.executeUpdate(); // 执行插入
            return 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 将高考成绩登记表 entrance_exam 转存为 稀疏表 sc
     */
    public static void main(String[] args) throws Exception {
        Class.forName(JDBC_DRIVER);
        Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
        String[] subjects = { "chinese", "math", "english", "physics", "chemistry", "biology", "history", "geography",
                "politics" };
        try {
            ResultSet resultSet = connection.createStatement().executeQuery("select * from entrance_exam;");
            while (resultSet.next()) {
                int sno = resultSet.getInt("sno"), score;
                for (String subject : subjects) {
                    score = resultSet.getInt(subject);
                    if (!resultSet.wasNull())
                        insertSC(connection, sno, subject, score);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}