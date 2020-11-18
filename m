Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903EE2B7BDB
	for <lists+linux-s390@lfdr.de>; Wed, 18 Nov 2020 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgKRKxr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Nov 2020 05:53:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRKxr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:53:47 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605696825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wBzWrDyOuw7+DNTmpBhibZApmtZg6H5uUTLz5Nq/X3w=;
        b=o7yom/f9qridLthiyXZgYz4M5jdc+CKB39WnezxXpu69/ewubXccAZdxCdx29pv48bEQYU
        CsW9BPvDxpeGw/afcJJ+jtpGV7VW88OpJkJov/YgBiDXmpS9NzbLc5iy80a7aBcMu0fvFG
        2Nq4K312kgyxBSB5fY8M/vSXk4NzLcOZyMZg8wda2kqwVXQpsRH9Wm4TlYPHrA7yb41lVO
        4UknuCD90j21nEK5x4znFPWhh37m3bdNYMTXZo9dMDWyoHFfKDwHtO1DqqVoecyba3CHAL
        xln/xsVZwxCUe9xNzc2t0wiathwjUQ5XJuZeJLrwplrHluyUjiDChR21o0TxIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605696825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wBzWrDyOuw7+DNTmpBhibZApmtZg6H5uUTLz5Nq/X3w=;
        b=elQG7lkcjR1Ub2xeA7faufteKisgXXcXHIEiiiatqAH245YOtJ21d3S7NYxp8NDvM4Y2yD
        aTGeaWSRESE2vPDA==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/6] s390/ctcm: Remove gfp_type() usage.
Date:   Wed, 18 Nov 2020 11:53:11 +0100
Message-Id: <20201118105317.605671-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Folks,

in the discussion about preempt count consistency across kernel
configurations:
  https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/

Linus clearly requested that code in drivers and libraries which changes
behaviour based on execution context should either be split up so that
e.g. task context invocations and BH invocations have different interfaces
or if that's not possible the context information has to be provided by the
caller which knows in which context it is executing.

This series is removing the gfp_type() usage which uses in_interrupt().
Overall it appears to be a nice cleanup according to the diffstat.
There are still two in_irq() users left in ctcm which I'm currently
struggling with.

Sebastian


