package JDBCConnect;
import java.sql.*;

public class UserManagement {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/pnusw37";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    private Connection conn;
    private PreparedStatement pstmt;
    private CallableStatement cstmt;
    private ResultSet rs;

    public UserManagement() {
        try {
            // 드라이버 로딩
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 데이터베이스 연결
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이버를 찾을 수 없습니다.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("데이터베이스 연결에 실패했습니다.");
            e.printStackTrace();
        }
    }

    // 사용한 자원들을 반환하는 메소드
    private void close() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (cstmt != null) {
                cstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 사용자 추가 메소드
    public boolean addUser(String uid, String uname, String email) {
        boolean result = false;
        try {
            // 프로시저 호출
            cstmt = conn.prepareCall("{call InsertUser(?,?,?)}");
            // 매개변수 설정
            cstmt.setString(1, uid);
            cstmt.setString(2, uname);
            cstmt.setString(3, email);
            // 실행
            result = cstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 사용자 삭제 메소드
    public int deleteUser(String uid) {
        int result = 0;
        try {
            // 사용자 정보를 deluser 테이블로 복사하는 트리거가 작동됨
        	pstmt = conn.prepareStatement("DELETE FROM user WHERE uid = ?");
            pstmt.setString(1, uid);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 사용자 검색 메소드
    public ResultSet searchUser(String uid) {
        try {
        		pstmt = conn.prepareCall("{ call SearchUser(?) }");
                pstmt.setString(1, uid);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    String uname = rs.getString("uname");
                    String email = rs.getString("email");
                    Date rdate = rs.getDate("rdate");
                    System.out.println("사용자 정보:");
                    System.out.println("이름: " + uname);
                    System.out.println("이메일: " + email);
                    System.out.println("가입일: " + rdate);
                } else {
                    System.out.println("사용자가 존재하지 않습니다");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return rs;
    }

    // 사용자 수정 메소드
    public boolean updateUser(String uid, String uname, String email) {
        boolean result = false;
        try {
            pstmt = conn.prepareCall("{ call UpdateUser(?, ?, ?) }");
            pstmt.setString(1, uid);
            pstmt.setString(2, uname);
            pstmt.setString(3, email);
            result = pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        UserManagement um = new UserManagement();
        try {
            // 새 사용자 추가
            um.addUser("user7", "사용자7", "user7@example.com");
            
            // 사용자 검색
            um.searchUser("user6");
            
            // 사용자 정보 수정
            um.updateUser("user6", "새이름", "새메일@example.com");
            
            // 사용자 삭제
            um.deleteUser("user6");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}