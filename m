Return-Path: <linux-s390+bounces-3289-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B104E8A21D6
	for <lists+linux-s390@lfdr.de>; Fri, 12 Apr 2024 00:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8F28699F
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50BB47F42;
	Thu, 11 Apr 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="HrE7Vx3V"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579046558
	for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875207; cv=none; b=FYFBRdccCHv2vHmEoG7l/WUxI4tZ7jruIk776BIEjSQioB7HPuH2qlHC9hA8eAWm9I4uxganxHKFiXKkMckwZjWWv2l0VCY0DnjfMOK+0apX2JmZ6J+2knteAZMzaPmWf3Fpja1549VNM5HrX1Dai1Od/hOQsQ1c5nlceIDCXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875207; c=relaxed/simple;
	bh=S4TnsFcjuXgA9nuQRAvIeS3/zSNBm8/9BgUmS0MLmqs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ukHZ8uZ8jpCauihr3lylKFKnrHi6TpSB0KnoNIbr+dnBu7pc5TyLeUU8c3W3e0/M/Xen8v6Lk3Kqwa/9buJJg5OpGW0I07TcGlafR1BXS2mqF8TtSqDEBWLqpW2wYgzt2i9cHtf8N1UxR6nYRrF34oQnig0E91eBefd3K6EvY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=HrE7Vx3V; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so2816611fa.2
        for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712875203; x=1713480003; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4TnsFcjuXgA9nuQRAvIeS3/zSNBm8/9BgUmS0MLmqs=;
        b=HrE7Vx3VsjO9zx09zpOJKe5SAZpjbJiQlry9KLYoRT4w8RbuXZeMwwSh/XEXQESIck
         gKMtNsMOwu9skWe5ekfDSLBm9kAKGi6YBVIC3zq9r8w2dIOlyjPm54EOXt6ohzfsymWF
         cDzSb8jCYm4lcNa8gKha+9ObHZf9RrEPBm+D1TdrFVFbU1vkRKRrbxomgI18JDI02dXL
         cnJEIiUlTz6UgXyGQUrkOXv+UjTQZKKbD9r7+S62qMAbE7sw33tjxBw+CrspLAqlSGlZ
         MxDn6xfZu/vVjV2ou24iQm57Z6ry3iRc/F8pO+WVLF7OOEwOoFiggiVktAhIxaqG3Nwf
         ilHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712875203; x=1713480003;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4TnsFcjuXgA9nuQRAvIeS3/zSNBm8/9BgUmS0MLmqs=;
        b=MvcFxGB/XcwTigQF5fYGhd3yaBgUca88M/dvmvwxIIHtlUke1dNMG6/MZ7CLAs8+BV
         wuQv41s7azvvV0XyTKiqH667fu6lWRMBnRKurbVk/jaSRUetMRpXBaKuBDWx3atyjPOC
         xCz2fKHHZzraHc6Sa7I7r9siKenLhEMm61NCmJUT3/375KH6iBk5U30NiY3FVWK1Vs/0
         bzB0LkcLaepjGMrhciqfgOmYf5Zm6W9JJgzItGYAxecD2poAB+P4viUIYWINOAJtEaGs
         FFZL3iUI+Q/vSw5TgwSa5jDZBV+bEGAlL9uqYtMYGxobMPVegCSXROqVgPiN7SlqHvK9
         EPjg==
X-Forwarded-Encrypted: i=1; AJvYcCX8jifoaEQ/0Ig6ykcLPM8ZMsFoFkaHURc/KQEJj1uXH2CFbI/ydsOvJ6oywcHCF1M3WhyKpezbbD7AI592Z5Nne45N+voI4hqqtA==
X-Gm-Message-State: AOJu0YxHHBeSns1080Jg26VeLHD8dlt7GBysQH6FGLpRuqw9WJlE/4MA
	AbX9FCGfkv+KfnsVXEyx9K4CnBcJB+YYLQFWSoNK9qdx15C/0J48WXidHlAP468=
X-Google-Smtp-Source: AGHT+IGY8qJhojjfCfabFUjR9vvGK5A/WLCfM1Bk52OhJKElMImmd0eUpMrnmf84M99SmcErfv1epA==
X-Received: by 2002:ac2:57db:0:b0:513:eeaa:8f1f with SMTP id k27-20020ac257db000000b00513eeaa8f1fmr649500lfo.47.1712875203340;
        Thu, 11 Apr 2024 15:40:03 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:a470:5d20:8e1a:464a])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170907761800b00a46aba003eesm1144762ejc.215.2024.04.11.15.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 15:40:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
Date: Fri, 12 Apr 2024 00:39:51 +0200
Cc: kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org,
 speakup@linux-speakup.org,
 intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 linux-afs@lists.infradead.org,
 ecryptfs@vger.kernel.org,
 netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-unionfs@vger.kernel.org,
 linux-arch@vger.kernel.org,
 io-uring@vger.kernel.org,
 cocci@inria.fr,
 linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <193B959E-60A3-499A-BFF3-EA7B2D0B6C12@toblux.com>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
 <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 11. Apr 2024, at 17:25, Dan Carpenter <dan.carpenter@linaro.org> =
wrote:
>=20
> It's tricky to know which tree a patch like this would go through.

The patch is based on the mainline tree. Should I have sent it directly =
to
Linus then?

I'm relatively new here and therefore only sent it to the corresponding =
mailing
lists.

Thanks,
Thorsten=

