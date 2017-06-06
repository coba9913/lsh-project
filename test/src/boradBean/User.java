package boradBean;

public class User {

	private int num;
	private String name;
	private String pass;
	private String email;
	private String title;
	private String contents;
	private String writedate;
	private int readCount;
	
	
	public User() {

	}
	public User(int num, String name, String pass, String email, String title, String contents, String writedate,
			int readCount) {
		super();
		this.num = num;
		this.name = name;
		this.pass = pass;
		this.email = email;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.readCount = readCount;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	
	
}
