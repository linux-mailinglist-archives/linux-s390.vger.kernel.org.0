Return-Path: <linux-s390+bounces-20892-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WuOQHuGbMGqtVAUAu9opvQ
	(envelope-from <linux-s390+bounces-20892-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 02:42:09 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11BE68AFEA
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 02:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cXKx2If0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20892-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20892-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6293031CE0
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 00:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A325B099;
	Tue, 16 Jun 2026 00:37:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C11F09AD
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 00:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570256; cv=none; b=BTFyziHXdK7mCsXGzOdYjg96gtyAaF4qKYaD3jL8FNVs3E2pGUfxwgt/e5UQDEJ2IeqRlKmA4oCR0c4e8Sl2ZUNfT92fsvk8FEZpOtLS1QAEF6CXicmfXKxyo6lsscNw4O6XRxKijemWK8xhoFbAoPeHzXCf6zhFnxNWOhzv2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570256; c=relaxed/simple;
	bh=p91yC0380ci6RVyhXJ1kuAXKj9VL+EWnmfNds5Mm5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRgmpETIOqu2jQX6vKjF9Ttx/OEAXQcFTzTj/KtI+imZ1wA3Nano1TOfFJgT1P/AU7cDcLcHK+S+5xY1JB37GyprN+VN7+gD6vcXdQ4ueev1TLArNsxDCjUDKMPcV8Z/aEn0hPaGYlXUW3LO3t/kGTcuM5byQpVC5uzglsM5nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXKx2If0; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso29288755e9.1
        for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2026 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570253; x=1782175053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFPF4sC2peklNMGORgGTd/4IxXXegAkw7S2lBmPrG1Y=;
        b=cXKx2If0O5uoxGazgOHP2e49iqcvTwTtqYvtYQ9fxEj297PwBpNzV1VGOo+P1bkdGZ
         pL8m/dAJG5/eXlbYJAe4BGkMPFSh7fZJz4GaymjDJVG2iiqVkXPONzbNYNblUaCt9IcO
         3ZPVUlbW/pCjck7mIZNaubCIpo/sWpoKe5YBxE7W+GmPlVgY5Yq4pZuUqcRCHJsZgFfh
         FQuLtOkUOb+zRGi5yMdTORX5WquRPRlKfP9mJi4fBnyLdTpx8lV+dSfDbhxM1yVUJ56d
         yXkQuOJaIe+9pzY1LpC+7WX2iP94q9CkdvyMuevov+StNCINA/hSlxgm0j7bZV/ge2pe
         upqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570253; x=1782175053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFPF4sC2peklNMGORgGTd/4IxXXegAkw7S2lBmPrG1Y=;
        b=KQOUKmXVgVrDDAunY1wqm3EHEkzTNsctsl+P392PZnmI8el/L3H1ERcl6/W8s8jUEv
         5EEIcqMIsgPFOfZHGinMbxET8p3wxC2NzCLay9LBCUzlCgYrt7ngJu0yu2PcEqZ3sPot
         UiIRdIAz8jMJWQFAj55PhMp+xWoks9b4wQ2galcuDtoonTwgPpFw+BL0z2chDfPdIgC0
         4spUcdgwfbNGpWPSpZkG3O3V48ToywuHzrWDqmjydfSov9mr2L8L5u8YoyzsfTzRejx3
         W1xdcH9laQoJTpdWO+BJDHw0ia9dtmPDdxtumC9E2Eik56/J1N2qmYtzGUJZTp2s2R/l
         SwZA==
X-Forwarded-Encrypted: i=1; AFNElJ/GQZIm6Oh+S8JqiBjABrHKSRnMkoNZglRb3ln8sMnSP1l8pV+SX/fKDHwSkh0pWT0St6c4PNLLNts6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+5Z8XS/bMAEKwlSkUTO0/vdhqCTLN+6ci4d0AALUYUYp2inM
	9Y70zK/y7VObcCzb6IeXpAwZq48vVsiAr/bRSc7HMA1BSm1/HVphinpw
X-Gm-Gg: Acq92OFISYFhwDCHq/FQ9UP1uby2DD9rilnPKSy+XjWZK8QRJybLslohmPtDO4TBob5
	aIhun85xWyqWjHJo1IOIZ8Mrg3GzGeMTEudJb9lraNdYBxKkbe6auVVzUHhZt0O7/GseHxMD26c
	ivEhujjMbBMNV3J9XYUT/iu9FGrHPI5WMml2uyyluFPwr/+L14gpLTcVO+kP0kI9TgnhrAW3GFt
	q7yfqrlUG3Vg4Lth0oCoDm5IfHkpAqSbuuiZ1MZyejRKER8PIgoxV8p5DB2uXcn6uGDuR7zc/I0
	KprM9XbNfkStQjzB2X8uhV7cskDAsmT0fk6SwwfEJgqMS0PQXa/zq4ZjAY6ESW/7Q8SMSwqg3DV
	KKT8tOlbxWfwGXJwQOndRBGKWfBIoLWaNHDMDYf+l6EZFnc4NAo1W2elTmq/b0oU9UOxjw2Fd5t
	Aa6+HdB/AM6WKyFUIwgU4=
X-Received: by 2002:a05:600c:698c:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-4922ffbdad4mr19600415e9.32.1781570253120;
        Mon, 15 Jun 2026 17:37:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490ea4b39e9sm238270495e9.0.2026.06.15.17.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 17:37:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: agordeev@linux.ibm.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 16 Jun 2026 03:36:59 +0300
Message-ID: <20260616003659.4002764-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
References: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20892-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-next@vger.kernel.org,m:linux-s390@vger.kernel.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D11BE68AFEA

Alexander Gordeev <agordeev@linux.ibm.com>:
> Hi All,
> 
> This patch as commit e2c0b2368081b ("vmsplice: make vmsplice a trivial
> wrapper for preadv2/pwritev2") in linux-next on s390 causes the selftest
> tools/testing/selftests/mm/cow.c to hang:
> 
> # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP (128 kB)
> 
> Recently there has been changes in THP area, so the problem is not
> necessary linked to this patch per se.
> 
> Please, let me know if you need any additional information.
> 
> Thanks!

As well as I understand, this test uses vmsplice to pin pages.
I. e. if my patch lands, then this test should be rewriten to use
some other mechanism.

-- 
Askar Safin

