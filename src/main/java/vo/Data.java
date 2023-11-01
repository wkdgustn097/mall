package vo;

public class Data {
	// public, private
	public int x;
	// 정보은닉
	private int y;
	public char c = '남';
	
	// 정보은닉된 멤버를 캡슐화
	// 캡슐화는 정보은닉된 멤버를 간접적으로 사용하게 해준다
	public int getY() {
		if(this.c == '남') {
			return 0;
		}
		return this.y;
	}
	// 캡슐화는 보통 허가된 값, 허가된 인물한테 사용하게 해주는 용도로 사용된다.
	public void setY(int y) {
		if(y < 0 ) {
			return;
		}
		this.y = y;
	}
	
	// 

}
