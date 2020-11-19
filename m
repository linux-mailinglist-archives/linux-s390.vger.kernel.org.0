Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB97C2B8F20
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgKSJh2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 04:37:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgKSJh1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 04:37:27 -0500
Date:   Thu, 19 Nov 2020 10:37:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605778644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTHT8cPd0jDwWbny9tN1Ak7mWAynHqebtYgRe9ofWgk=;
        b=g1EfcwvZpMfLA2hSW9npT+QgEHftZMwqOXOT/uCQDpf0IrwXrTVIfaszm275NfFfD8pkDr
        RZVKNK+mGpTMTNFGuPLRWZLOU8826AGtwQLfSSsEBxoq0BahuqVz5OG2eImyN3HJUVL4ll
        U8tBfZuTu2RSxHdZiWQZOIzoNQ9KbSUEDHKf8ZWQPuCzwKTefHV5JB04XmDFYqlgKDdOc+
        a6KEY83x0BUToZ+z1ZWl6EvtV2SQi/ahHd5YwJ/DfIbfO+3qTyL6NLigWpcrh0g9refJ2k
        2GLAKMyyq/8yqDdjMH6ClsmsojCer98zf2A+01jOBsxeX93QxwD39UNRC7bqdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605778644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTHT8cPd0jDwWbny9tN1Ak7mWAynHqebtYgRe9ofWgk=;
        b=mv9K8Agvo52RDjAQsfkqqcqvz1VVt2c6PsB+0eq5TqQHNBAILMWka1WfmwNmqfg8o6vLHv
        iFEq5BxVSLXJ0nDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
Message-ID: <20201119093723.xbwq2o3k2k7kc2z3@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
 <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
 <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
 <10c005bb-f590-d213-8e43-f3411248e79f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10c005bb-f590-d213-8e43-f3411248e79f@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2020-11-19 10:16:28 [+0200], Julian Wiedmann wrote:
> I am not worried about performance at all. Yet readability matters.

As you wish. Let me respin it then.

Sebastian
