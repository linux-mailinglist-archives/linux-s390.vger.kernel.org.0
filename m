Return-Path: <linux-s390+bounces-21278-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nm6JHB0iQmoa0wkAu9opvQ
	(envelope-from <linux-s390+bounces-21278-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 09:43:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB176D71E3
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 09:43:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FM7oxT9Z;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21278-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21278-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70156309A6D1
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93E35C1BD;
	Mon, 29 Jun 2026 07:35:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87169347BDC;
	Mon, 29 Jun 2026 07:35:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718557; cv=none; b=YUjI5jyyyMHyY/eOh7IEpB5IL+5WGMZysmj9FNmq/a4VMqEmxCE3kFstyZz5JgShT0rGsZG0t+aXQHgvjjQTaQPor0D/3aiPiADd643CBqVaUZvCLoTAsuARPZFhZhQrkozD0RkTJUSPjXvL6ZT1zbUXudxD8pSJzaJzqhW7wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718557; c=relaxed/simple;
	bh=2zatEBFdK9tskA5xMCuwhriCR8d/k+4Lgiw5vm1QE50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+HDKN4jikqnbIia3P9LXCKkAfcmlq5xvHw2YCacox3s+bynk7tlbulfF7nYpCDkCghjNnxzdL2KryqZ+E+kATPcEhWvqP0QVQ7JiGUevorIvoDRcT5NmEQ8wgjMFchAIOrvFh4vSjdyr04bgjzn2rvaCj3Z8d/ZjKvUwOo9qh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM7oxT9Z; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782718553; x=1814254553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2zatEBFdK9tskA5xMCuwhriCR8d/k+4Lgiw5vm1QE50=;
  b=FM7oxT9Z00r0Jia8D4c6tgFm1iEbwfgohqbVZx1Ui1tE1Ehebbq2VpAd
   mqW827tsiti+qYgEhJaZSY3uFZ2Rfe/WyHOlVHw12dMYFd9K119nwNvWm
   XHRwjHtyIeM1pg9SvuF9iwE2hZ+5qUziUCBVCqO06balM/gMy793rAGd4
   5qfm0ymGXw+6K/r/+JLusWd2A/z8ydjTlhMkPW3azH6FOIxMRBvQWRnYn
   hCSKBbjEuiUEGX5vlwwqWmDERYpf5U3+xnIMFiKWCfh4r/aDwAe51DwBb
   CREvSRxQU2cVV44JYpYE3SBBdI8Dt/DtQ6HrGC8F1gk7dMdx68AYW3YDv
   w==;
X-CSE-ConnectionGUID: ju54942sTPC0980juBxX2Q==
X-CSE-MsgGUID: qbpfCqX3Qiue6pgJpTg4KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83276365"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83276365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:35:51 -0700
X-CSE-ConnectionGUID: LA/j0INTRCeqBSkQMZkB5w==
X-CSE-MsgGUID: SxLdSLYtT0OyqBtaePGndw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="250189857"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:35:47 -0700
Date: Mon, 29 Jun 2026 10:35:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, linux-s390@vger.kernel.org,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>, Josh Law <objecting@objecting.org>,
	Kees Cook <kees@kernel.org>, Md Haris Iqbal <haris.iqbal@linux.dev>,
	Richard Russon <ldm@flatcap.org>,
	Stefan Haberland <sth@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>, vulab@iscas.ac.cn,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
Subject: Re: [PATCH v2] block: partitions: Use seq_buf_putc() at 24 places
Message-ID: <akIgTBcvrZLfY2iL@ashevche-desk.local>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
 <ajzkRM_RFKBpp0i5@ashevche-desk.local>
 <7de415a7-457d-4dd2-aebb-8e179fa0bbcd@web.de>
 <aj061omzs5WN5ar6@ashevche-desk.local>
 <7360cab3-7a2f-4903-85f1-0f03387b0d88@web.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7360cab3-7a2f-4903-85f1-0f03387b0d88@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21278-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:linux-block@vger.kernel.org,m:linux-efi@vger.kernel.org,m:linux-ntfs-dev@lists.sourceforge.net,m:linux-s390@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:dave@stgolabs.net,m:hoeppner@linux.ibm.com,m:axboe@kernel.dk,m:objecting@objecting.org,m:kees@kernel.org,m:haris.iqbal@linux.dev,m:ldm@flatcap.org,m:sth@linux.ibm.com,m:thorsten.blum@linux.dev,m:vulab@iscas.ac.cn,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:rostedt@goodmis.org,m:woradorn.laon@gmail.com,m:woradornlaon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,wanadoo.fr,stgolabs.net,linux.ibm.com,kernel.dk,objecting.org,kernel.org,linux.dev,flatcap.org,iscas.ac.cn,goodmis.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ashevche-desk.local:mid,vger.kernel.org:from_smtp,linux.intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBB176D71E3

On Mon, Jun 29, 2026 at 09:16:09AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 29 Jun 2026 08:10:24 +0200
> 
> Single line breaks should occasionally be put into a sequence buffer.
> Thus use the seq_buf_putc() function in these implementations.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> v2:
> * Andy Shevchenko requested to preserve two blank lines.

This comment in the context of the given commit message may be odd.
The blank lines mentioned were in the code that previous coccinelle
script removed, id est the code

	...blank line...
	seq_buf_puts()
	...blank line...

the script transformed to a single line

	seq_buf_putc()

So my request is to keep the original blank line(s) as is.

> * The source code transformation was extended to all affected places
>   for this software area.

-- 
With Best Regards,
Andy Shevchenko



