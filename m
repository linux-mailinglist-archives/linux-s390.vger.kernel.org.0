Return-Path: <linux-s390+bounces-21732-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D5Q1CFAeTWp+vQEAu9opvQ
	(envelope-from <linux-s390+bounces-21732-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 17:42:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18571D647
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 17:42:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=R86JuE7i;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21732-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21732-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8DE73019390
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2026 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6743149C;
	Tue,  7 Jul 2026 15:38:54 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B84430CD3
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 15:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438733; cv=none; b=m8kTPsnErl98sXvf7UnaKzZ2rket8EKEKM8MDFiY4iYire49/JuajFI7+nmqU8/UcWPgt0XVRoz32h/dKBq8kVlQVcnRqcF2SdKPESlMqLXVuJErZMFgAVVgFVCvjWwcsONfHMz/rTP7bJn6ILakRyp/OAtbizh7eLNf4qoXx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438733; c=relaxed/simple;
	bh=gkAPXKFXbOoLtNAqBKO7qS549Qi1Dzx+1+ovFhoFLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2fOfbOavb9mUMJPHks3nRl3Nc+9XNyAplpl1x7ojeKeuMAwiVz4RHsWm1yxT3s93dTE8RhqO/3AbqTHpL3fuwJry82k1Y8wdL7R7jSFYTI14LR/wtp5rdW43gyX7mITHFRmAdbZvwqJWPezZMMX3IsPYPcJvVed4u1KoTchaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R86JuE7i; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493e497643fso1687725e9.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438730; x=1784043530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vOu1MKmEYCbchrybWpjcqmihonsI67IBicqKFbwWsc8=;
        b=R86JuE7iMp+pe9TRfWpgbxlD+2LwCFrwojttgNNChu371QHvC0r/Ris1eMX0yk5G9d
         8ViWxkM/wi4+4u6C+FYfT1TZCvknxYI+CtOOo49uvkSQVX7vu12y9DBTTDr3OvCvHwuQ
         ZVBscPOurQ+zEDFWjggRpHPtpUNAqpByr6DM4FRPwmMJVPrq02VGHdJMBC7i6q1xEXY+
         Z2mh7UMr4DpgSo+H0n66sqmIZyVzUnOml1k4BW9ym7RL+Yzunw+DvbFXsWDW3Idd29Hi
         pj9RsiFeVxs2T1B2fvCfcswPXg2tg0BSIyVhLiiJ1WvqBD1rM+oecl1Jj08l/s2S1GDd
         +wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438730; x=1784043530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vOu1MKmEYCbchrybWpjcqmihonsI67IBicqKFbwWsc8=;
        b=RrTcZLUbjqGsga5PqKfTVmYJNxKPdsqiczZbSTt5cl3THLSd0nRgMfNgZu+H5TkDDT
         DUt75h7L5x2H8q6UuLNlfdv2v4UkRJeJgj9nmbMlAd9MKmmqq42z0CcntKy9iZNfrj+k
         Kenhdx0OiZpdKEYuw8rgnX1exx5Jlvu7FUsJo0iO/hhfU2Zw4vzjNMONOIjDBWYyLQeD
         KgtzPhtWS7LSIKrQGCaIRUudlihk22rgsugpPuZ49jVMbOyCvgZAzeEoPaPTX9G7Fhkt
         lr/ikxDyFvfz1yNk5E7naD127znRGohWbL8cvJ8dsYq3k97Ug4QFX7KTxBRW2deA2rf1
         /KFA==
X-Forwarded-Encrypted: i=1; AHgh+RqdVC2tkNSKqox1RSdzZv7NpgAeaYrCzmmTWyqgkVgDO1B5sU8g8tGayeSD+trcUxlo+vguxMflsOTL@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnoeBrA4j7FXLsVVhnJjNxANCk74j7TkFs/+oLPsro0+WMds9
	FHOOV8NM2Yy6Mu0p5AWHfKAQT8hzeRhs9v1JsJ4K7fV/ThK7/Cwpecq9pfWFRLYCvjg=
X-Gm-Gg: AfdE7ckBx3lDs36ntj1gJ67E8pkG4C3BsZ1/cvm1Gh8n3FCI29wbd9p5+i+dTK8TY2D
	Wbdw1w2ligjE68oeYRPx9872Zek0RSnjQ3Rzj6P5ll5OGEfnWb88PcwmlGBqW8nCCqt0eM16+wI
	/NzZ85IXnwyC14CgwalZzMG3i76D8+KA47BqWLaYf3wJeYbuvT1fBf98x3UrvPs6ONBZfrp1yCv
	cSLvV1cAFGnPlfGbtwR4azghpCQx3RNjZCQSAq3SxnBROUzORQKjWbN0L+0K1kZb3EC8e/zvZsK
	cge7KHnEK7NfHHLLJyl4OsvJQb4Lrtmtw4CapD7YFVRofs99P2SkxmscapoogkTnS5Dkag674Qp
	e1muxLnVBbMCGNeDhmLVJpVIK0RxeWfidKR68kXxBCaaQNZhJX0faz29GFCcxyfqwd2CVk9JsWM
	0diuVNWiIA5XcspmexrnW0Ao4QVh5d4BBxE48NKN5/eKh19u662ezJKHbVNuiPn0wHxtSgUpyu5
	3Iqc9mnQyWQEg==
X-Received: by 2002:a05:600c:a293:b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-493df064c39mr42510935e9.16.1783438730221;
        Tue, 07 Jul 2026 08:38:50 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:49 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
Date: Tue,  7 Jul 2026 17:37:06 +0200
Message-ID: <20260707153819.4172541-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-21732-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:xin@zytor.com,m:hpa@zytor.com,m:luto@kernel.org,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:jgg@ziepe.ca,m:atomlin@atomlin.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,linux-s390@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux.ibm.com,gmx.de,suse.com,google.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C18571D647

The drivers/char/tpm/tpm_crb_ffa.c file uses kzalloc_obj() and kfree(),
which are declared in linux/slab.h. It currently relies on this header
being included indirectly through linux/module.h -> linux/elf.h. Add the
missing include in preparation for removing the linux/elf.h include from
linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 025c4d4b17ca..af4466cdc297 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -12,6 +12,7 @@
 #include <linux/arm_ffa.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
+#include <linux/slab.h>
 #include "tpm_crb_ffa.h"
 
 static unsigned int busy_timeout_ms = 2000;
-- 
2.54.0


