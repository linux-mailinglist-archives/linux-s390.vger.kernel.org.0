Return-Path: <linux-s390+bounces-16022-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNjYKcYXdml1LgEAu9opvQ
	(envelope-from <linux-s390+bounces-16022-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 25 Jan 2026 14:16:54 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC6809FC
	for <lists+linux-s390@lfdr.de>; Sun, 25 Jan 2026 14:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91CE63032F75
	for <lists+linux-s390@lfdr.de>; Sun, 25 Jan 2026 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7ED319852;
	Sun, 25 Jan 2026 13:14:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3531B117;
	Sun, 25 Jan 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769346866; cv=none; b=tmwjZYfcy6nMLsXJTTX/eVKWSErlvg7of2HwIF2dUUkFs2QbY6swMJtjf5F3uLkvcIAJQ9a+arHDluhmykPRKCXdFkrBb5C9Y2pGXhQ5AqstC53was75rIN2vBjk0GT48rCaJhI6h99JUz2ZPx/CSY1T7GT08QkxiJd2d/Q0bV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769346866; c=relaxed/simple;
	bh=wCYComRYh/0eukGCvEwfbJyZ9wozogqelCAmEDHqta0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fRK2pzp8eNVrr2Vjc71nzNv8nxAwxCjamiSaDty/YIYHacqPGGzx4yK/QIladnMqZPBUnrF0qFiNHwZObCXKLs0ye716oMmlJtqZsRFXb7xwCFfzNxerFHJDxo3FjR3Kzqlz7LVW7cLXswzIGd9mNKwFDwc97l5J2LkyuZ1PMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowABnaL8nF3Zp6W6rBg--.43718S2;
	Sun, 25 Jan 2026 21:14:15 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	mingo@kernel.org
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] s390/con3215: add unregister in tty3215_init()
Date: Sun, 25 Jan 2026 21:14:13 +0800
Message-Id: <20260125131413.2042746-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnaL8nF3Zp6W6rBg--.43718S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4fAw4rXrW8JF4xCF4fGrg_yoWxCFXEkF
	WIqr9Fyr45CrZakry5Zr4Sv34v9F1rWws7uF1ftFy5Jr1xWr40qFyjvFW3Gr1DXr47ZFyD
	tryDGFnYk343CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAcSE2l1qZuEdAABsV
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16022-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,linux-s390@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isrc.iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 76BC6809FC
X-Rspamd-Action: no action

Add ccw_driver_unregister() if tty_register_driver() fails.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/s390/char/con3215.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 56e43d43c713..3ffa5ac075c7 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -1181,6 +1181,7 @@ static int __init tty3215_init(void)
 	tty_set_operations(driver, &tty3215_ops);
 	ret = tty_register_driver(driver);
 	if (ret) {
+		ccw_driver_unregister(&raw3215_ccw_driver);
 		tty_driver_kref_put(driver);
 		return ret;
 	}
-- 
2.25.1


