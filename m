Return-Path: <linux-s390+bounces-21733-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2VWKG2keTWqYvQEAu9opvQ
	(envelope-from <linux-s390+bounces-21733-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 17:42:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F25F71D68B
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 17:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=MmjH9P0K;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21733-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21733-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22084301A17C
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2026 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6D342E8F9;
	Tue,  7 Jul 2026 15:38:56 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CD42CAEC
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 15:38:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438736; cv=none; b=LUtullNFmO1Zx+OotwzXHDYfS59e3NVWOZSVZCWGo3iX5XCBhtYvWDn8eK2zegGgBpR429eh3i7BfBNq7YjQ9hU/XQXN2U86gltf/mKdL3aXXnImwAA5lFUWVfL7UfOMpnUL2E6at5oHsQp2DzEG0y1js+Q6FFIp6S++34vJGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438736; c=relaxed/simple;
	bh=WlxI6D6l0R5RgwB+XCAILtOwfVKifVrQwkT3eMDmrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y59Uvu85aeRCtOAOcVM82usHg2d4PAVYtuI0TTaMjo4RIrX7iAvPNLX9AX9tkFR/SMui3J0VSXj2ynQ27Hxm68Ef2oJasO7Z7vPE/YzrC3aMWjodu5olmRdUwM93TGL9G/Lk19SMnGoiUITzKGmaO+q8LrQygltCoudciQLJRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MmjH9P0K; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9551055e9.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2026 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438732; x=1784043532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=MmjH9P0K3E2AunaKnGG94wC0VVYj8cpOvWmGsRK/OKaVA9NvRb8DIQZ1pmpY6aKx6+
         Mh9SJbU353ZwUt61sFItSAOcbmwbbRcb8V7bn6T5XJCdCnf4nJah1QbXV3gmOqEpv5y0
         BlqfDR3ymtTkdEh8Q/z4Fs/WKPvP4MkRntZ/KmtPkUychE6pHwJZ7O1JKLo8e576aHaC
         w1RFtzhg3T6zSmOIKZDJLL7VltpO1rbdlO3n2ToP3bmg1ELTdbqpiZkeTC3GHI4yyeBA
         hKDp9n1qiLLDN/JExEDVBKhvkcBoVsnzpwf70Lh5krwZCPoQIqGtBQJY3nRCju3+migS
         eOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438732; x=1784043532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=cg3qTjFl9CLdPFgwHiZn2Dpqu+2ymkIREgCWnkf5MbDtoDckW11tIBDpIpyP+drfUw
         RcrLLNfQGtlj5rdw+DGU2wR7asMUOf07us1nRRb6bhFdy6wFN9XLeUaBgMBBrsRhwZgi
         wzM1Xh+bZwqyAvvJKgZ32uN75pdUFiipbZGjw3zmlMeG9SDBSRsmd/GiRzoxUbcL+Gx4
         rOfuvLTFMIkQmAq7eCJytk7jIysxZ1f7IlkyfCk9nnf/Adm+SEvYCHN27TSAAqZRbM7R
         wQa/2dzjUYnSDXwPrPzlexqH5LuHttNWKmAy7x7a8VY3/OUsiJu2O8vFUxjsHWNbIiw6
         XkkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0aJewijaXlebHacXog5rMiC0d7RDAmWSmntyv0fY6L6/J2v3afyngZyrrJ2loD5IXf28YPl9/2l8k@vger.kernel.org
X-Gm-Message-State: AOJu0YyoPyV/nIzFJNZwBJSMJhX2HmL9B/W8gFPzyDTPYjJvc467PdHU
	Z6Twr8MZuHMTS8G3wlR8WDFcd+was9RqcwMPuVeW6wkWCz8PmsNdMx2S0MVOVIKtqUE=
X-Gm-Gg: AfdE7cnrmhHywoEwtDidaGvyqHE+KdFcsGNDJElxj/kmj9KZHkLOnn0GAbgucKEBlhv
	Fe9mOYcpwIyd7mcX3LiDLW2tyTSzVSQzJn5RmaGIJ2q1jB4WBNdHaafElt/jRpW/2kD33sJc/IT
	bMP2yBEPgra9MKSiXEs2aUkckNuUz9uNhY0pCaW9JgrOWfl925zFIeZbvPOLzmTcfF079VPQW6s
	0lxGksiBjUTrN6RwCsdg7Osp/oM6ASMnMXCjTqfbzmxqNpahjGQU68ixOEdyFHOix+8i7O8OeKD
	QtXy1WTIE00LxtU0HeWheuRT9YMgvNaeHghkekUEn0duI1W1BE6lBtwqs9ULr4cNKD0QK7+JBG8
	ItsxdnpLsDleAISf4e0gEUhRQ9iGYDNvEA56wzSS3lIcn8OCKxk9XnEjWnH8OW1CtS6avSSitAY
	WhbMoBXUYQ3iOlX99zCyGt4bGYpIjUXLLhNl1OGhXd8VUyLuOOPMqxO8pQEQvRxVxL4tmBNmtMm
	/oToAQWcVHJLg==
X-Received: by 2002:a05:600c:8010:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493e1011e8bmr32534765e9.9.1783438731805;
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
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
Subject: [PATCH 4/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:07 +0200
Message-ID: <20260707153819.4172541-5-petr.pavlu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21733-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F25F71D68B

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..7661faadbedd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -17,7 +17,6 @@
 #include <linux/cleanup.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
-#include <linux/elf.h>
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
@@ -29,8 +28,9 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
-
 #include <linux/percpu.h>
+
+#include <uapi/linux/elf.h>
 #include <asm/module.h>
 
 #define MODULE_NAME_LEN __MODULE_NAME_LEN
-- 
2.54.0


