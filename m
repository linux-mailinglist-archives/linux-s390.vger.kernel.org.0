Return-Path: <linux-s390+bounces-21384-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SMgYJ0L6Q2q4mgoAu9opvQ
	(envelope-from <linux-s390+bounces-21384-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:17:54 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B86E6D50
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:17:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=knPzO3U6;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21384-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21384-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683B6302570C
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2DF3DB32D;
	Tue, 30 Jun 2026 17:12:56 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5733DB30A;
	Tue, 30 Jun 2026 17:12:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839576; cv=none; b=YoBiSJ6XtXkAB8o5HHijEPQhaT/BpytWRDzTmyI9+H2IJTtCeBreX7hSbng4z8HWnLmsfvVXmF+xKVIzgtOQEa7jRjwipARwme5ifdUOIlFA716+/Q9cyCTxPDNqkH8z3e888JjRi+VgLd83gVjdtC9fxSLX6JprYgF8n7/Wb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839576; c=relaxed/simple;
	bh=5xcJL5kstQMzzj80gwor3p/0k5AbaW7a13i0t1vRdXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/dygxlMzUSJQk3xy9aAMV4e+ABQNMv/0lmtbAxsIztox7aqU9zNwHtQS7FISz8IsoD1OWgycCpIPrzcQ3Qn+dL65iLknzjP7+A5uDA385EgXz1W1F9OwINECiY7FjOjjHp3W0ILkllkgfOjhkalrGwNg8JKU5g1mXvcb0wWj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knPzO3U6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD91F000E9;
	Tue, 30 Jun 2026 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839575;
	bh=X86Sy1gHJXCr7jMFQ390SVl+ZOGmKdw4abSC4IVsUJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knPzO3U6UsciU4oI+O7LTObjcQMoYoX41F0vr8+mcTL3y7rRe5Eh+EUs6wIluKUov
	 eVDoYYWfUrS8BeTRtTBb2H+ho9lxjdgHDYF1m9Cbai1ExpSjTMckdJgc2qt/wS9sZ3
	 wLd3IdMdob80a+kohatp/SBwB2Ui9QsYZeG2uACfwxiFGRzNiCE/j4ImG2ADC6+vfv
	 S8EQHKg+Fy+S7CMylg36Kyft0BkkbGxE4UtP4cVLmEjIQz+dL5wta8mT9PGYF8NnVZ
	 KDyqJRRgkIDIVJlQ/HDZa7wZrxoTj+eumBN0xqFQko9X8y4a7ywGBTJvSHO+63cN3H
	 qd5y7uPj48adQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630164807.643-5-alifm@linux.ibm.com>
References: <20260630164807.643-1-alifm@linux.ibm.com>
 <20260630164807.643-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:12:54 +0000
Message-Id: <20260630171255.20BD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21384-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-pci@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328B86E6D50

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Blindly restoring a stale PCI_COMMAND value introduces a TOCTOU =
race window that can erase concurrent modifications to the register.
--

commit ff043ecd9c4375492e235cd366b469432d15d4f3
Author: Farhan Ali <alifm@linux.ibm.com>

PCI/MSI: Enable memory decoding before restoring MSI-X messages

This commit modifies the MSI-X restoration path to temporarily enable the=20
Command register Memory bit before writing MSI-X messages. This prevents=20
Unsupported Request (UR) errors if the saved device state did not have=20
memory decoding enabled.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 209373c92e9e1..79c7e84d314b7 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -870,6 +870,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	bool write_msg;
> +	u16 cmd;
> =20
>  	if (!dev->msix_enabled)
>  		return;

[ ... ]

> @@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  	pci_msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> =20
> +	/*
> +	 * The restored device state may not have Memory decoding enabled
> +	 * in the Command register. Since the MSI-X was enabled for the
> +	 * device, enable Memory decoding before restoring MSI-X.
> +	 */
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
>  	write_msg =3D arch_restore_msi_irqs(dev);
> =20
>  	scoped_guard (msi_descs_lock, &dev->dev) {
> @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  		}
>  	}
> =20
> +	pci_write_config_word(dev, PCI_COMMAND, cmd);

[Severity: Medium]
Does unconditionally restoring the stale cmd value here introduce a race=20
condition?

The function reads the PCI_COMMAND register into cmd, enables the memory bi=
t,
and then enters a potentially sleeping section by acquiring msi_descs_lock.

If another thread or subsystem modifies PCI_COMMAND (such as changing Bus=20
Mastering or INTx disable) while this lock is held, writing the stale cmd=20
value back will silently overwrite and lose those concurrent modifications.

Additionally, if PCI_COMMAND_MEMORY was already enabled initially, does the=
=20
code needlessly expose the device to this race instead of skipping the=20
register modification entirely?

>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630164807.643-=
1-alifm@linux.ibm.com?part=3D4

