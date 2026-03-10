Return-Path: <linux-s390+bounces-17110-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ISGLyY5sGlbhQIAu9opvQ
	(envelope-from <linux-s390+bounces-17110-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 10 Mar 2026 16:30:46 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 112042538F3
	for <lists+linux-s390@lfdr.de>; Tue, 10 Mar 2026 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647D9324DC37
	for <lists+linux-s390@lfdr.de>; Tue, 10 Mar 2026 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CB302165;
	Tue, 10 Mar 2026 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z//TMhtC"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075752FC01B
	for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154739; cv=none; b=gHRwO3U7rrdcy59L6MMz8JqLjSsZvFeNDNQOWZZqk729YVJPHmM8bSowiHhL6aCutx//+YR137jsgF3UOnmYQgf5aB/epf+u7jHszhPFk8nrAt8p1Bvzy2KJGd038vJnhIJV/6HmHAWVWebArUQYc5lTvs6QpQBRUwuP0ZWZ1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154739; c=relaxed/simple;
	bh=S+anfbSwaDJsvX1PlPr7RWxLq/UCfSI4a9XfAmzsRbw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kxIk0oG8HX1CwhVF/rkg6W9CaIllb8lSkTLrxZ2dcW1JUbzgWn1RVP6y8CdJPEsCWe+Zmp2eMc1Eof5TJaflIEtB3RV0rYf0ApusZszRmQpIZyT0UaE6UjY1PqWGFCdGUMDdkyf224LkNP/UO+E76VGT/JI6FpguuUzkJsP8X9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z//TMhtC; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f387a688dso6318326fac.0
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773154737; x=1773759537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlzuJzaGVqKByGHYMWwVZYmu+ZMyTR6bqnVlHDMtpUk=;
        b=z//TMhtCBxTE9BvEBDwxf4BUAt+KwCe9apbfRDimIPC8cjo38ABUwSsutVrT+MQeG9
         0hyWTfpDlIYFYekjI7hkUP71KdgqCads0x5TFywDbLiXuGjT7pi0h7iC/5pysGWHQT00
         CHErLO0lWji0EZNvI2yPt6MCmCePndOdXLLBcNlUshzxTvD2hhubUSNJc4RHBApGf73X
         Bq6egDcVdch5bGx3t0tgakbup9+Y40jA9Q7Re1qNjW0S5rIFq8nhjYRWls5b71thui7V
         BgeRssHqDRawbET/Vay6FGDm5Gfq0dTwsSJLER0I529AYXCbzcylMvgSPV+2nLPS7AkW
         pCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154737; x=1773759537;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlzuJzaGVqKByGHYMWwVZYmu+ZMyTR6bqnVlHDMtpUk=;
        b=lf9/wF+YWkhzKdZfisqMvIpy1cK/wclsieG5yPD9xnCoXdXQ/kOSas/Vr3glu/3nGG
         WJBlwcCqvbP9brA/YkiITtmTbFIVDLE255zVZYUKtwQ3gTKOIx3R1LZ6CpkVDYVcAu40
         NKmKy0DRYhJyiyLlFFoW4ohrHBkJh9aIDlKETeBTIO4rcn/idBlNGiaCEpshbl/AhbzS
         Ou4dWSZb6/lj1Ejbnt9x7+y3J8Yyan96alCJ5A6h/pOLQ/6DD9jPk33xSzWmfXzY6ceK
         Y+liphsgqw0ysVEcGA5yLEBhOx0ueRWYrsx5Jj1j2oeI2x9WOhr9lu5FZh4SpTZjiAlo
         hsgg==
X-Forwarded-Encrypted: i=1; AJvYcCUvrehjaMo6TvO3r6G5D1SDwHT5I4Fg+7lpvnc7T36HeUwAT2hqfM3Z1+j7KdSon1p40uEAePVGjRME@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZYO6XH7hoPf7AKkMW/zFpMypl//mOMi4usnDp6pKvGn9lH8M
	cxc+VYX9v8YMZJk41Odj1bF0Fzx/tRflRO+qkcB1GMCoWXaiVkATm50mxYejaSIZaPuBv2uQDSq
	H9UUG
X-Gm-Gg: ATEYQzy2BkgImFNMOosPFaZrqlz3F+jHSXahrk0TgVKsXTlZwCdybrwoOZ0OnyRjlPH
	gLo29wa/Doj/fVlq9VZDCBtffsBfY502c9obbPdPeolsnHW5DyC+kgHCVOdnRCI2BTlAheo8AYN
	H2iMfNVlJfN77OeCO5+q4S99lHSvAbmWW8r5A1QbGG4UV8kuiB//YZHzP/icNswOuC8KwohZtpH
	m0bqj9OpQkkL6UFdrtAcbeFr4C/SCIP1ZyEDdINjyBuMKZrp7HoFOgM3bSVVTnb9Q9fO+LWFAxD
	2QiSTrG6v4vmvKTB2+9oqTUwmhTukkiUinHlODAspOy5yfqTYn0o3g6CAdHLRKQoMykS8yovTf/
	ec2QBDez6Qm4+eMGsKYe6vGcBpqL3/tlHmMIffS1wjeIPf3RgvDZsqG26pWzrInpnIez7k+R7Lv
	032sF640iSaqE/VSbzUhZveLvd86fLMkQrGeAf4nbNSaUvIPfJms90fAoR5YPF2smm9J9LN4G+V
	Irx
X-Received: by 2002:a05:687c:2703:b0:417:3a5d:c2f1 with SMTP id 586e51a60fabf-4173a5dd3d8mr3479186fac.7.1773154736920;
        Tue, 10 Mar 2026 07:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dcb1e8sm2924913fac.16.2026.03.10.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:58:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260310142330.4080106-1-sth@linux.ibm.com>
References: <20260310142330.4080106-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: copy pair swap fixes
Message-Id: <177315473593.70675.6747808910460583265.b4-ty@kernel.dk>
Date: Tue, 10 Mar 2026 08:58:55 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 112042538F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-17110-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


On Tue, 10 Mar 2026 15:23:28 +0100, Stefan Haberland wrote:
> Please apply the following two patches for the upcoming 7.0-rc.
> 
> Both patches are straightforward and address a rarely used code path.
> While users are unlikely to encounter these issues in typical
> deployments, the second patch is important as it addresses a potential
> data corruption issue after a disk swap.
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Move quiesce state with pprc swap
      commit: 40e9cd4ae8ec43b107ed2bff422a8fa39dcf4e4b
[2/2] s390/dasd: Copy detected format information to secondary device
      commit: 4c527c7e030672efd788d0806d7a68972a7ba3c1

Best regards,
-- 
Jens Axboe




