package mall.bank;

public class BankDTO {
	private String card_no;
	private String card_com;
	private String member_id;
	private String member_name;

	public String getCard_no() {
		return card_no;
	}

	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}

	public String getCard_com() {
		return card_com;
	}

	public void setCard_com(String card_com) {
		this.card_com = card_com;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	@Override
	public String toString() {
		return "BankDTO [card_no=" + card_no + ", card_com=" + card_com + ", member_id=" + member_id + ", member_name="
				+ member_name + "]";
	}
}
