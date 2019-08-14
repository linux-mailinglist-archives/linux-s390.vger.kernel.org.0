Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1208C817
	for <lists+linux-s390@lfdr.de>; Wed, 14 Aug 2019 04:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfHNC3H (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 13 Aug 2019 22:29:07 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41461 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfHNC3G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Aug 2019 22:29:06 -0400
Received: by mail-qk1-f174.google.com with SMTP id g17so10724824qkk.8
        for <linux-s390@vger.kernel.org>; Tue, 13 Aug 2019 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=m5QQIHgaURy+lRyPupTLPy/4tvsA3s//zCshh/63PoY=;
        b=qHTw/LnBVKC9bXkyhI/TLHAaLs5XRMxYREUdsJzpDmR5QHScsN2gCrJkPNq3JmnxqI
         /zjcgbLDhnK04kMuL2wmrSyljYmO2rfx5hvpIXiblI9hDM+9nSVs3yvBPmWswL8IdgQQ
         yDdW+Ja+6nnPrFNnSRzxPy7vma4+a4bcZl2k8PR0aA/AiHM+/X2r1WdaAm2TsvbAHtZC
         2coTDYagc/sfHKuPUJoe9VI51Auca0afzL+CYl9QXyWrMsqvBSvYkk6yCrEKhbXbkMnZ
         HblkAgtK3Arm2Gn0kqvSJ9K7jHndt6UJWAeos4PORKDQ9drd4TIPoOiorHKt0SOTE4oa
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=m5QQIHgaURy+lRyPupTLPy/4tvsA3s//zCshh/63PoY=;
        b=qvyI8tihQFZtTkeagTlxGWauas0qStobWb4r2jMcRNva3LAjRIpTg+0kLXqDcxMr94
         G+CpWEcE2jkEZTM9UxMSZ0gFTRsIXE0wz4m5ePPEbJ55JbH8QRzskY9gvJII0b+JZC30
         zmyAVl3u7mvPqSLg6UFSMl5O+Zl0PMljx4Uq1lus749lXHT5+aaxrHPhb7aMjrfPBhGE
         zZ34Evse/Lx32y4WxoZSh8Lr56cffqxzu/ESMxSUEneJ1EFvCQsGOUyugaW0rj688Hpl
         Sd8maYBYmnL99ma8p/ar3TibPMgpzjeVE3SS366YuMM5l+sYdrqAkiEsLmXWwbtB3ji/
         4uWA==
X-Gm-Message-State: APjAAAUa/ItqlhITFkeZTVDPTEm2OcKaE547gCFltKn+4b2odKxzmBsF
        xrCV+mJuT/+bJmOMW0RdejCFeA==
X-Google-Smtp-Source: APXvYqzLMMw6FHiol+IbtYP5HS1AaXUUQvXwdJakUJOkuTe0+CgcdXGxytSTk1lzmosjOZyFz52Lzg==
X-Received: by 2002:a37:648:: with SMTP id 69mr36692682qkg.248.1565749745852;
        Tue, 13 Aug 2019 19:29:05 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id b1sm22867873qkk.8.2019.08.13.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:29:05 -0700 (PDT)
Date:   Tue, 13 Aug 2019 19:28:55 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: Re: [PATCH net] s390/qeth: serialize cmd reply with concurrent
 timeout
Message-ID: <20190813192855.4d37cb89@cakuba.netronome.com>
In-Reply-To: <20190812144435.67451-1-jwi@linux.ibm.com>
References: <20190812144435.67451-1-jwi@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 12 Aug 2019 16:44:35 +0200, Julian Wiedmann wrote:
> Callbacks for a cmd reply run outside the protection of card->lock, to
> allow for additional cmds to be issued & enqueued in parallel.
> 
> When qeth_send_control_data() bails out for a cmd without having
> received a reply (eg. due to timeout), its callback may concurrently be
> processing a reply that just arrived. In this case, the callback
> potentially accesses a stale reply->reply_param area that eg. was
> on-stack and has already been released.
> 
> To avoid this race, add some locking so that qeth_send_control_data()
> can (1) wait for a concurrently running callback, and (2) zap any
> pending callback that still wants to run.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied to net, thank you.

Please consider adding the Fixes tag for net submissions.
