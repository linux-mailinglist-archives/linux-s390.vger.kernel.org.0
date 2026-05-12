Return-Path: <linux-s390+bounces-19592-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HRgGoBnA2qa5gEAu9opvQ
	(envelope-from <linux-s390+bounces-19592-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 19:46:40 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0A52615E
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A12306B361
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661593E0738;
	Tue, 12 May 2026 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaNElIr7"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D13CDBDD
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607827; cv=none; b=ezjiMozhCJAg0dYUsMhX4zoWii2TsIFYn5eG2Cknk02Teeq6oclKuiq+tjMphuR58a1jh4/NVX5ZDuHtrmA5HKfJCCQQ2+E74YGleqI2iPTUCNkfbrN44Mqyz2lRvj91TSdQusEHEBvY80KdVU4MhaOM06j+AJjLWXnDG0tnsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607827; c=relaxed/simple;
	bh=4hMpz9IU/uwDFrIduflHUvfH+zn9i091lrWCzQ3RzfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jf8FK1ldDsRi0r4ph50ip3zeCSqVFFldbCd8XZYyWXpau6FvD6Mqmgew4VN+HFJGx0DUcAe39a6G/LPlPR78EIA/buaHrCBBoO0qjZvDgzAQ6U87Go0NV6FDOcvc5RELLUh5sJVbhsz2UQzm5796sH9faR9q95H9qfFgymDY1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaNElIr7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so4440105f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778607824; x=1779212624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bQsYfl6dRJnMsTlZum51r7UJJ5K++DgCVkUEYqn/RVE=;
        b=LaNElIr7emJ7hUbamvVsqRhWZXXlxI94yQR/U18qQ7ydCsuuxaJ8UW1TxxQvRVLiLG
         uX8exWwN63mKcx7+kxyXiOnhBNgG342X7Gvg99tgajS7QgQmOltPSm7+he/KUp1sjRF9
         Wr4mvHiVsXjxPsKxmukMJONM4X3cLlT2kKLDOTuOfYH34ILW/46aRnYklJKKkx2Uwf0e
         qlFruZvVXS6IV+SSwy43UfyW6zRhu21y0te/msp7EI+h2Ux+z/nb5iOzrd2x/OuctBk2
         bMXYibHxBzSKIP5YpDtuY4uQsh3uM37OMLQ9nLoayT1Ho+RJ9y92Y98W87pzWmtulxEi
         1fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607824; x=1779212624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQsYfl6dRJnMsTlZum51r7UJJ5K++DgCVkUEYqn/RVE=;
        b=aUDDi2hGZ72D54cBgyC1AOJS96PE0AGVQ2pwEU8hMXjPhn6At/JixGWLM6w+n+Zw+k
         RWrDEfFaGE1Mn0vHhFbOkxndeg6j2NG8Q8H13n7KJablYjUBFi2txuf/Eot4vHRzjt4m
         RoNGvirDqBmQW/2wAPJl2mwJhlh9YV7aIuqdu3g0N0eF5qgbTbzsf8c3G2SRXm8Tz7nC
         u3uGL+5I4xNfNkPFftU0a9zh2DkIKhahB2QsivudSFilLwMt4gNonBZbSFVeYjwojO3q
         +iBun+htVZnzFX3VIAgI0xnSJisA5n+PKfwIiIMjFFsFnLVxSkuLFu5FvWfIMcH8GY8j
         /RGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MUPgIYZiIzI6s6ViQEzLZzy/MnKNP1DD6tIkCr09BJG37OnTDh0na+HBu0hCFc1Y/gbeKHY5VT/pI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0mLVltfP/9pM9ntLRlfVPxrlj5Rmru4ohxXsqtiIy5m1qPJQ
	/raepj5d2hc7F1yojdcn6lvQ2r8ip9zaUAaV2iekmvhG3tdE69bVSA7VKq86qYpbHswLWQ==
X-Gm-Gg: Acq92OEJ1BB9002R16TZqfcrDR3SgaOINZqxjNTp/PiOKAziVKeGMeG1CknJkml7MRE
	uWQ9PrwVLJldGNKdaqFtJKRS9teT05BCy34BvNIqYgNJJWrqe/dsfiixf1VIu4TyB2orxG1sLlJ
	mG4uppHieWSyFR1haWhbZLe0opoUIyWIllcaI1Yoi/4tgUtZYQo17m32gz2vuaGzC1IYSsWKejr
	8VFYJj0fHLUmINKJPO1VfTbgq/+l5WJJLo0y3zzD+FJ2fw8St8fZjPgbuyYNYHXfwyoq/YzQupA
	oN3/+ufXCgMuns46/wDr2PIBcdg3q2yotEVKXd6+KJrC+KoiZOxJyzBKOIrw4WGbetcgOT0arYH
	zKijVuesvRxHoL7O5mUGSvdNZDWvaU6W7OJouZ+z3o/dj/H4LWRIh9eayLQsRoZwmacHKioRSG+
	fSW04cLFFGiqYjzbU9dvHY+P/e9WoFvb6JXl8vF1BRm3dDFD6YpIsChD8=
X-Received: by 2002:a05:6000:430b:b0:449:b7dd:4a75 with SMTP id ffacd0b85a97d-45c474bc2ffmr12736f8f.20.1778607824273;
        Tue, 12 May 2026 10:43:44 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm32458092f8f.1.2026.05.12.10.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:43:43 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	iii@linux.ibm.com
Cc: meted@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	akpm@linux-foundation.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] s390: cleanup kconfig defaults for selftests
Date: Tue, 12 May 2026 18:43:36 +0100
Message-ID: <20260512174336.907050-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0EA0A52615E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux-foundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19592-lists,linux-s390=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Remove the unconditional defaults of 'n' from the def_tristate statements,
which shadow the later 'KUNIT_ALL_TESTS' default, causing it to be dead
kconfig code.

Also, include S390_KPROBES_SANITY_TEST in KUNIT_ALL_TESTS.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/s390/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..4d7c492c6bca 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -999,9 +999,8 @@ config S390_MODULES_SANITY_TEST_HELPERS
 menu "Selftests"
 
 config S390_UNWIND_SELFTEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	depends on KUNIT
-	default KUNIT_ALL_TESTS
 	prompt "Test unwind functions"
 	help
 	  This option enables s390 specific stack unwinder testing kernel
@@ -1011,7 +1010,7 @@ config S390_UNWIND_SELFTEST
 	  Say N if you are unsure.
 
 config S390_KPROBES_SANITY_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable s390 specific kprobes tests"
 	depends on KPROBES
 	depends on KUNIT
@@ -1023,9 +1022,8 @@ config S390_KPROBES_SANITY_TEST
 	  Say N if you are unsure.
 
 config S390_MODULES_SANITY_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	depends on KUNIT && m
-	default KUNIT_ALL_TESTS
 	prompt "Enable s390 specific modules tests"
 	select S390_MODULES_SANITY_TEST_HELPERS
 	help
-- 
2.53.0


