package oo;

import java.util.Date;

public class TicketHistory {
		String belegBezeichnung;
		Buchungsbeleg buchungsbeleg;
		Reservierungsbeleg reservierungsbeleg;
		BuchungsStornierung buchungsStornierung;
		ReservierungsStornierung reservierungsStornierung;
		Sitz[] sitze;

		public TicketHistory(Buchungsbeleg buchungsbeleg, Sitz[] sitze, BuchungsStornierung buchungsStornierung) {
				this.buchungsbeleg =buchungsbeleg;
				this.sitze = sitze;
				this.buchungsStornierung = buchungsStornierung;
				this.belegBezeichnung = "Buchung";
		}

		public TicketHistory(Reservierungsbeleg reservierungsbeleg, Sitz[] sitze, ReservierungsStornierung reservierungsStornierung) {
				this.reservierungsbeleg = reservierungsbeleg;
				this.sitze = sitze;
				this.reservierungsStornierung = reservierungsStornierung;
				this.belegBezeichnung = "Reservierung";
		}

		public Sitz[] getSitze() {
				return sitze;
		}

		public int getBelegID() {
				if(buchungsbeleg != null) {
						return buchungsbeleg.belegID;
				} else {
						return reservierungsbeleg.belegID;
				}
		}

		public Kunde getBelegKunde() {
				if(buchungsbeleg != null) {
						return buchungsbeleg.kunde;
				} else {
						return reservierungsbeleg.kunde;
				}
		}

		public Vorstellung getBelegVorstellung() {
				if(buchungsbeleg != null) {
						return buchungsbeleg.vorstellung;
				} else {
						return reservierungsbeleg.vorstellung;
				}
		}

		public float getBelegPreis() {
				if(buchungsbeleg != null) {
						return buchungsbeleg.preis;
				} else {
						return reservierungsbeleg.preis;
				}
		}

		public Date getBelegZeitstempel() {
				if(buchungsbeleg != null) {
						return buchungsbeleg.uhrzeit;
				} else {
						return reservierungsbeleg.uhrzeit;
				}
		}

		public boolean isStorniert() {
				return (buchungsStornierung != null || reservierungsStornierung != null);
		}
}