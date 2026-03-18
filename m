Return-Path: <linux-s390+bounces-17545-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBFvKgNeumkoVgIAu9opvQ
	(envelope-from <linux-s390+bounces-17545-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 09:10:43 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 221AD2B794C
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 09:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19FB030DBF5E
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4F377572;
	Wed, 18 Mar 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hgs+T34F"
X-Original-To: linux-s390@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B80376471;
	Wed, 18 Mar 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821008; cv=none; b=Ru9YA0finTL7vFLt+NuvUZu7P2NOXyAEp8ePV9Cownq6z4+1GpWHQUCL3tlo/REmyyNPjjhQBPEsirZNf9ITmKd3hzgrcDyz1HmESg3WqxwFq0ehYz/RzMd4wpdyoKO0l7r3BUdRkkUw+lxiewCY8kCM1+R+K2hpEYX08MKqr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821008; c=relaxed/simple;
	bh=DYXWvYfUSpZR5al96Sc7tYooTiT5m/o/92SYPPh2AnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnX9QSrj8Xi+FAQfDDaw/wLix0A5y2nWVKMqSSK1GVOHjrn7WEe+eGtA9t93eEfFcpebJldzFDiTXATl51jL9MrXRm3f4JFjKi/N33Hi9cvBA/DiY9gWI9/l81LZz6ndI7/5aYSOnacieShGAq1HjQijzxqRWPIOgIvxyFkXMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hgs+T34F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821007; x=1805357007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DYXWvYfUSpZR5al96Sc7tYooTiT5m/o/92SYPPh2AnE=;
  b=Hgs+T34FScwlR5Lg8DFNefu9pUq3UAEm02AQJN1RTqUF/MYLmagTqfsf
   qOvht2GodTQCD1lyxqLZ1zwPS9mj1wGZmdtJy/m/+9rZTWPe/AkGNTh9/
   zVRhhKD9gFPMfyl3swGlIJ2MVBvD2bFB0/Z5Q/7fAMp/8gMIVEkbDzaNd
   sfMMEQvCXUNZN6QwVyIG3mlI+5A6EMWY2+YRsgTHrUfysk/0iPV1ALkZW
   XeVDWUpSpaXW9pjBVhvVRQNgorGdVNl6h1tbLNN6kvqYI5xk7RGzb2klX
   zm1iqlL+wAWkoVRj5pN2W8UfE6H+MHU+5iT7zHqy3TjDeXo0TQyOTs1Le
   g==;
X-CSE-ConnectionGUID: 2zH8OoI5SGycT1vgvbskTA==
X-CSE-MsgGUID: D692jSN3Q+SHjOFr/MCd6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78478503"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78478503"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:03:26 -0700
X-CSE-ConnectionGUID: 6hGynHTmRC+qG+1/6uHngg==
X-CSE-MsgGUID: dbQF7qDPTSi1+VKz16axcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221777167"
Received: from unknown (HELO [10.238.3.211]) ([10.238.3.211])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:03:23 -0700
Message-ID: <dc7e1a7d-dc40-4644-a836-84c3a968811d@linux.intel.com>
Date: Wed, 18 Mar 2026 16:03:20 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com
References: <20260317110641.39975-1-tmricht@linux.ibm.com>
 <53039fb5-4785-48ac-8e9a-7b561a3242c6@linux.intel.com>
 <6dac1f79-ff68-4583-a108-e9d291422438@linux.ibm.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <6dac1f79-ff68-4583-a108-e9d291422438@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17545-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 221AD2B794C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/2026 2:27 PM, Thomas Richter wrote:
> On 3/18/26 02:52, Mi, Dapeng wrote:
>> On 3/17/2026 7:06 PM, Thomas Richter wrote:
>>> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
>>> removes arch_sdt_arg_parse_op() functions and s390 support is lost.
>>> The following warning is printed:
>> Not sure if I miss something, but it looks there was also no s390 specific
>> support for arch_sdt_arg_parse_op() before the commit e5e66adfe45a6 ("perf
>> regs: Remove __weak attributive arch_sdt_arg_parse_op() function") and we
>> would see same warning even without the commit e5e66adfe45a6, right?
>>
>>
> Absolutely Correct, but in my opinion it does not matter if it was your patch or if
> you just remove the __weak attribute. Your patch revealed the missing s390 support, which triggered
> this patch.
> If you do not like the wording, what do  you suggest?

I see. The original words lead me think the commit e5e66adfe45a6 ("perf
regs: Remove __weak attributive arch_sdt_arg_parse_op() function") drops
the s390 specific support unexpectedly. :)

So precisely speaking, we may say "the commit e5e66adfe45a6 ("perf regs:
Remove __weak attributive arch_sdt_arg_parse_op() function") introducing
perf_sdt_arg_parse_op() to support architecture-specific argument parsing,
but s390 specific argument parsing is still not supported. So this patch
adds the missing support for s390 ..."

Thanks.


>
> Thanks Thomas

