Return-Path: <linux-s390+bounces-21257-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id puU9MSAVPmqG/ggAu9opvQ
	(envelope-from <linux-s390+bounces-21257-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 07:58:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B54BE6CA86D
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 07:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=NDcC2ALq;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21257-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21257-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB40130102C0
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3862E888C;
	Fri, 26 Jun 2026 05:58:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AB2C0261
	for <linux-s390@vger.kernel.org>; Fri, 26 Jun 2026 05:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453531; cv=none; b=SkKO4jcAz7htRdpBg8dYvN1qNPr2VTlr2GJhpzM8XQ1IsKZg5vcH0pW6cPQKjLL7OjU0OrxkOSzfDRMFRLebTIwEk7qDI57nxdrm0owwqoq2+EvBqemwrGI1xv9oII43ucm/TnhXCEvgjNQvZHYq4kaVfcf3p7S3GRLt7oSfd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453531; c=relaxed/simple;
	bh=DNrspax3iIAkSClTzH1TA10APl48SnlgR6gYOLka8ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0iUt9QXDN9+td8C9u7L9JfrObvZde+QmUaiCoWmxSLST20lrmuBmGmMMO4KonHvCEpwE7pd+4CmdR/SkLw2b+HA6FUheDpKjcfNwjumTUAnWSx7/6DYpTmQPsgY0CJ53KibeMkDtZCtSfDhCiYRZZqakGSh0g2oRcAq61AUCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NDcC2ALq; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DY
	9eL2NCQVehO2ZX0x693cWjcVuKYuBwgetqkSxQGzc=; b=NDcC2ALq6fWlLOdLCu
	uFEbAjmCrfWqDjJYKho9UDNzEb5II1KIx9q76BY8k/cdMkTMKbInj4VauN6kAYNm
	nEpLkEXSq8t5ElvxXBdERIEoygDLmD2P1r2XIGNFezlzVbrpq9yqL4Accj4O9Od7
	0kAKoi0p36ae11y0zd7YXA1ec=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXrxAJFT5qcFmBFg--.48887S2;
	Fri, 26 Jun 2026 13:58:34 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: linux-s390@vger.kernel.org
Cc: freude@linux.ibm.com,
	hca@linux.ibm.com,
	dengler@linux.ibm.com,
	svens@linux.ibm.com,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v1] s390/zcrypt: Remove the empty file
Date: Fri, 26 Jun 2026 13:58:20 +0800
Message-Id: <20260626055820.376212-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXrxAJFT5qcFmBFg--.48887S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43tr43ZFyUXFW7GFWDCFg_yoW8GFWxpa
	1FkrW5uw4xG3yjk34fJr1rJFyrJay7CFWYgay7Xwn0v34xJry8JayIyay2yFy7XayrJF43
	JrZ5JFyDt3W7WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4gpx3Go+FQoeQgAA3S
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[clementwei90@163.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:freude@linux.ibm.com,m:hca@linux.ibm.com,m:dengler@linux.ibm.com,m:svens@linux.ibm.com,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21257-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clementwei90@163.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B54BE6CA86D

From: Rongguang Wei <weirongguang@kylinos.cn>

The files has no real user because CEX2 and CEX3 device drivers
are removed, also remove these empty files.

Fixes: 5ac8c72462cd ("s390/zcrypt: remove CEX2 and CEX3 device drivers")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/s390/crypto/zcrypt_cex2a.c | 0
 drivers/s390/crypto/zcrypt_cex2a.h | 0
 drivers/s390/crypto/zcrypt_cex2c.c | 0
 drivers/s390/crypto/zcrypt_cex2c.h | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.h
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.h

diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2a.h b/drivers/s390/crypto/zcrypt_cex2a.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2c.c b/drivers/s390/crypto/zcrypt_cex2c.c
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2c.h b/drivers/s390/crypto/zcrypt_cex2c.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.25.1


