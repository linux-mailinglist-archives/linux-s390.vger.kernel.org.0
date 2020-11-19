Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF502B93F5
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKSN52 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 08:57:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKSN51 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:27 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605794246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CUgs4yMvfZwwsRkVBq4eTBT8NOiYsLzwaQvaFKYH/04=;
        b=dVksx9NFBNi9g7yVauvK6NugZM/yGrnhfo1vTJ1OqXdBOfQcjixP09fFZC9T/Pyot0skCL
        qsOn6oyy2tWexEwcqABsP42GAs5BGHuErtGBcGZeORCeW5UYk5zVypaVll3+BdgAr0sNcl
        ufs5LQ9M1VTxSIg+L6KwQUu6Im7R8l4bPOuD5qU5orw7PjO0PoyON8ysS4WUXje6j7KzvW
        ljfPJc5KNrVhUBw4Box5mnnqPbIUx7aVUP1QoReIx7SNEA+pSzOmJ7852wtmIyTsSTCSUL
        WaZbNmuLVGR+c+9Ns/K/NdA/R1vwUgc4i2rhJxMDaeF+jY/PVbyCXuFwW7PkTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605794246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CUgs4yMvfZwwsRkVBq4eTBT8NOiYsLzwaQvaFKYH/04=;
        b=JtsIrfEjZRlSAUyuzgeMEcxCNR9nCkdTcLPMwvcgLamUtNidKAbDYrf/QG2CzZgBHc/tmf
        pfgaVws/Ay3sJ+BA==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/6] s390/ctcm: Remove gfp_type() usage.
Date:   Thu, 19 Nov 2020 14:57:12 +0100
Message-Id: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

v1=E2=80=A6v2:
	- Use the pointer from skb_put()/push() instead having it on
	  stack.
	- Collect acks for patch 4-6.

Sebastian


