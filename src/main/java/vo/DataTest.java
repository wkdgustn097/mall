package vo;

public class DataTest {
	public void test() {
		Data d = new Data();
		System.out.println(d.x);
		// private : 외부코드에서 읽기 X
		// System.out.println(d.y);
		
		// private : 
		d.x = 10;
		// d.y = 10;
		
		// 캡슐화 후 읽기 가능 
		System.out.println(d.getY());
		// 캡슐화 후 쓰기 가능
		d.setY(12);
	}

}
