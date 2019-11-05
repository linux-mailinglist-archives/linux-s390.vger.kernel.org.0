Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D3F0429
	for <lists+linux-s390@lfdr.de>; Tue,  5 Nov 2019 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbfKEReF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-s390@lfdr.de>); Tue, 5 Nov 2019 12:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390258AbfKEReF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 Nov 2019 12:34:05 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90A4FC057F23
        for <linux-s390@vger.kernel.org>; Tue,  5 Nov 2019 17:34:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f8so9817538wrq.6
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 09:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=BMfbrDDdhycp+V4IUo9GmouVBKVCyDS9gZpIOUXzmdo=;
        b=ApWLrHpiVop4Kf0HvRRbGFXkuzNtbGpzvlO/P11npYte9iUjx9f1ZLRxuw2muhhg/b
         384FbVijQ5BP2S+CA09rKd6mBwK7YMvckWZrHWhadsJS+aGEYjesVM2h7XXBBDXgwW0T
         g3HOnENI5c0BokAFAw8qhdFtvak5eVh1yjoGcHd6aSa4oZTy1b1Sn5BI0829xeohLrWq
         OjXvS1Jkj0jsFRsl+46n9G14H5JKStc2GoHJBxMUlu/cfcasZWYOuXItzp8LPMFAe9xd
         ZfwjFoP56yMybJQuBzE5Flv9GR7kuXrS3T/7gR7raZdWGTLk31JWrBeipvqBkSKHRxVj
         yBhQ==
X-Gm-Message-State: APjAAAV2LdMUqtPNnQBRoFtvyamYQScPuyo+mdu13KQmwBcw6amAYKlI
        jZ89mMLMkjInV5R2vCyUjFvViiBjjFLeSPxx3tmhUTLZbVK4W4q0d1Ic7NfqSElXvWh5cYlgQtg
        aLX6eh9VFXPmkGJREBVT9YQ==
X-Received: by 2002:adf:e903:: with SMTP id f3mr30854034wrm.121.1572975243318;
        Tue, 05 Nov 2019 09:34:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEckeFf7/gf8keUjBTJdxGv/uyLrloT6JORCYL32uo1D7t8nPmuWyHlbXT+13GL9phAIUBlg==
X-Received: by 2002:adf:e903:: with SMTP id f3mr30854013wrm.121.1572975243085;
        Tue, 05 Nov 2019 09:34:03 -0800 (PST)
Received: from ?IPv6:2a01:598:b909:23a5:e032:f549:e9f6:ecae? ([2a01:598:b909:23a5:e032:f549:e9f6:ecae])
        by smtp.gmail.com with ESMTPSA id t13sm14699974wrr.88.2019.11.05.09.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:34:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [kvm-unit-tests PATCH 0/2] s390x: Improve architectural compliance for diag308
Date:   Tue, 5 Nov 2019 18:34:01 +0100
Message-Id: <70BDB5DE-489D-4718-B6C2-0EABD89414D2@redhat.com>
References: <20191105162828.2490-1-frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com
In-Reply-To: <20191105162828.2490-1-frankja@linux.ibm.com>
To:     Janosch Frank <frankja@linux.ibm.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> Am 05.11.2019 um 17:29 schrieb Janosch Frank <frankja@linux.ibm.com>:
> 
> ﻿When testing diag308 subcodes 0/1 on lpar with virtual mem set up, I
> experienced spec PGMs and addressing PGMs due to the tests not setting
> short psw bit 12 and leaving the DAT bit on.
> 
> The problem was not found under KVM/QEMU, because Qemu just ignores
> all cpu mask bits... I'm working on a fix for that too.
> 

I don‘t have access to documentation. Is what LPAR does documented behavior or is this completely undocumented and therefore undefined behavior? Then we should remove these test cases completely instead.

> Janosch Frank (2):
>  s390x: Add CR save area
>  s390x: Remove DAT and add short indication psw bits on diag308 reset
> 
> lib/s390x/asm-offsets.c  |  3 ++-
> lib/s390x/asm/arch_def.h |  5 +++--
> lib/s390x/interrupt.c    |  4 ++--
> lib/s390x/smp.c          |  2 +-
> s390x/cstart64.S         | 29 ++++++++++++++++++++---------
> 5 files changed, 28 insertions(+), 15 deletions(-)
> 
> -- 
> 2.20.1
> 
